From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC] ASOC: HDMI audio info frame speaker
	allocation
Date: Wed, 30 Nov 2016 16:27:22 -0600
Message-ID: <52518fde-75e7-b4ca-9bd9-4dbc897ae495@linux.intel.com>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
 <1480325634-23320-2-git-send-email-arnaud.pouliquen@st.com>
 <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
 <5007d5a5-1f3b-b7ae-f923-43e839be381e@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D70126668C
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 23:27:25 +0100 (CET)
In-Reply-To: <5007d5a5-1f3b-b7ae-f923-43e839be381e@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 11/30/16 11:54 AM, Arnaud Pouliquen wrote:
> Hello,
>
> I'm trying to understand how to implement the speaker allocation for
> HDMI output.
>
> input:
>  - HDMI sink provides the speaker presence in ELD structure
>  - audio source can also contain channels position.
>
> output:
>  Audio info frame (IF) should contain audio channel allocation (
> hdmi_audio_infoframe structure).
>
> So if i well understand the concept, application should be in charge of
> aligning channels with HDMI sink speakers...

Yes. However some HDMI IPs provide hardware means to swap the channels - 
mainly because the order of channels varies between OSes and encoding 
schemes. The notion of 'aligning' might be limited in those cases to 
setting the relevant ALSA controls, not necessarily an active software 
channel swap and change of the channel map handled by the application.

>
> Regarding HDA driver, audio IF channel allocation is computing based on
> "Playback Channel Map"control . Application set the speaker information
> of the audio IF through this control.
>
> On ASOC side, in hdmi-codec,
>  -'ELD" control exists  to export speaker information to application
>  - info frame channel allocation is hardware coded in
> hdmi_codec_hw_params. The configuration is set by default depending on
> the number of channels. Drawback is that application is not aware of the
> configuration selected by the driver.
>
> So it seems that something is missing to do the link between EDID
> information and audio source channel mapping on one side and audio IF
> configuration on other side.
>
> What should be the best strategy to support feature in ASoC?
> - No update in hdmi-codec, consider that application should know
> the configuration available for 2,4,6 and 8 channels
>   => seems not very flexible...
>
> - Update hdmi-codec to implement "Playback Channel Map" in read-only, to
> provide channel mapping information to application.
>  => impact is light, but application can get the correct mapping only
> after the update of the number of channels (so after hw_params ops call)
>
> - Update hdmi-codec to implement "Playback Channel Map" in read and
> write access.
>  => HDA implementation. Seems the more flexible solution from my windows...
>
> - Implement control in drm drivers
>   => seems not reasonable.
>
> - Other?
>
> Thanks in advance for your answers.
>
> Regards
> Arnaud
>
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
