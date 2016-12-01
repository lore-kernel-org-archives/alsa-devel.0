From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC] ASOC: HDMI audio info frame speaker
	allocation
Date: Thu, 1 Dec 2016 14:58:32 +0100
Message-ID: <11c47adb-931a-aea1-ec42-70150d74c2ac@st.com>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
 <1480325634-23320-2-git-send-email-arnaud.pouliquen@st.com>
 <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
 <5007d5a5-1f3b-b7ae-f923-43e839be381e@st.com>
 <52518fde-75e7-b4ca-9bd9-4dbc897ae495@linux.intel.com>
 <s5hshq80xq1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B759326648D
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 14:58:37 +0100 (CET)
In-Reply-To: <s5hshq80xq1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "broonie@kernel.org" <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org



On 12/01/2016 11:07 AM, Takashi Iwai wrote:
> On Wed, 30 Nov 2016 23:27:22 +0100,
> Pierre-Louis Bossart wrote:
>>
>> On 11/30/16 11:54 AM, Arnaud Pouliquen wrote:
>>> Hello,
>>>
>>> I'm trying to understand how to implement the speaker allocation for
>>> HDMI output.
>>>
>>> input:
>>>  - HDMI sink provides the speaker presence in ELD structure
>>>  - audio source can also contain channels position.
>>>
>>> output:
>>>  Audio info frame (IF) should contain audio channel allocation (
>>> hdmi_audio_infoframe structure).
>>>
>>> So if i well understand the concept, application should be in charge of
>>> aligning channels with HDMI sink speakers...
>>
>> Yes. However some HDMI IPs provide hardware means to swap the channels
>> - 
>> mainly because the order of channels varies between OSes and encoding
>> schemes. The notion of 'aligning' might be limited in those cases to
>> setting the relevant ALSA controls, not necessarily an active software
>> channel swap and change of the channel map handled by the application.
> 
> The application may just leave the channel mapping as the driver
> default, too.  It's a freedom for user-space whether to accept the
> default channel mapping as is, or choose the own preferred one.
> 
> For some IPs that can't handle the channel maps fully, the limitation
> can be implemented in the driver side, I suppose.  It just needs to
> pass the limited set of channel-map array the hardware may accept,
> instead of the arrays that are created by parsing the ELD.
> 
>>> Regarding HDA driver, audio IF channel allocation is computing based on
>>> "Playback Channel Map"control . Application set the speaker information
>>> of the audio IF through this control.
>>>
>>> On ASOC side, in hdmi-codec,
>>>  -'ELD" control exists  to export speaker information to application
>>>  - info frame channel allocation is hardware coded in
>>> hdmi_codec_hw_params. The configuration is set by default depending on
>>> the number of channels. Drawback is that application is not aware of the
>>> configuration selected by the driver.
Erratum: Channel configuration is not updated but always set to default
value 0: stereo FL+FR, even for more than 2 channels playback.

>>>
>>> So it seems that something is missing to do the link between EDID
>>> information and audio source channel mapping on one side and audio IF
>>> configuration on other side.
>>>
>>> What should be the best strategy to support feature in ASoC?
>>> - No update in hdmi-codec, consider that application should know
>>> the configuration available for 2,4,6 and 8 channels
>>>   => seems not very flexible...
>>>
>>> - Update hdmi-codec to implement "Playback Channel Map" in read-only, to
>>> provide channel mapping information to application.
>>>  => impact is light, but application can get the correct mapping only
>>> after the update of the number of channels (so after hw_params ops call)
>>>
>>> - Update hdmi-codec to implement "Playback Channel Map" in read and
>>> write access.
>>>  => HDA implementation. Seems the more flexible solution from my windows...
>>>
>>> - Implement control in drm drivers
>>>   => seems not reasonable.
>>>
>>> - Other?
> 
> We can start from the read-only chmap ctls, with a plan to enhance
> to the read/write later on.  I guess only few applications require the
> channel map change, and the hardest part is the proper integration in
> ASoC, not the write support itself.


That seems reasonable. If OK, as a first step I will try to propose
chmap control in read-only with some predefined configurations in
HDMI-codec.c.

Concerning channel allocation in HDMI_CODEC, Proposal is to align
channels location according to HDA default ones:
(hdac_cea_channel_speaker_allocation struct)

static struct hdac_cea_channel_speaker_allocation channel_allocations[] = {
/*			  channel:   7     6    5    4    3     2    1    0  */
			 /*mono or stereo */
{ .ca_index = 0x00,  .speakers = {   0,    0,   0,   0,   0,    0,  FR,
FL } },
				 /* 2.1 */
{ .ca_index = 0x01,  .speakers = {   0,    0,   0,   0,   0,  LFE,  FR,
FL } },
				 /* Dolby Surround */
{ .ca_index = 0x02,  .speakers = {   0,    0,   0,   0,  FC,    0,  FR,
FL } },
				 /* surround40 */
{ .ca_index = 0x08,  .speakers = {   0,    0,  RR,  RL,   0,    0,  FR,
FL } },
				 /* surround41 */
{ .ca_index = 0x09,  .speakers = {   0,    0,  RR,  RL,   0,  LFE,  FR,
FL } },
				 /* surround50 */
{ .ca_index = 0x0a,  .speakers = {   0,    0,  RR,  RL,  FC,    0,  FR,
FL } },
				 /* surround51 */
{ .ca_index = 0x0b,  .speakers = {   0,    0,  RR,  RL,  FC,  LFE,  FR,
FL } },
				 /* 6.1 */
{ .ca_index = 0x0f,  .speakers = {   0,   RC,  RR,  RL,  FC,  LFE,  FR,
FL } },
				 /* surround71 */
{ .ca_index = 0x13,  .speakers = { RRC,  RLC,  RR,  RL,  FC,  LFE,  FR,
FL } },

Thanks and Regards,

Arnaud
