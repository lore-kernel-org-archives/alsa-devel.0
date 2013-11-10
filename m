From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: speaker-test chmap bugs (was: [PATCH v3 0/5] ALSA:
 hda - hdmi: ATI/AMD multi-channel and HBR support)
Date: Sun, 10 Nov 2013 09:25:07 +0200
Message-ID: <527F34D3.40209@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>	
 <5269665E.9050102@iki.fi> <1383887323.6455.37.camel@Wailaba2>	
 <527CBC7F.4000805@iki.fi> <1383934622.22680.2.camel@Wailaba2>	
 <1383946119.1089.4.camel@Wailaba2> <527D5FB4.6090603@iki.fi>
 <1384062124.29274.8.camel@Wailaba2> <527F2126.50006@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id BE235261A0F
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 08:25:12 +0100 (CET)
In-Reply-To: <527F2126.50006@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Langlois <olivier@trillion01.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

10.11.2013 08:01, Anssi Hannula kirjoitti:
> 10.11.2013 07:42, Olivier Langlois kirjoitti:
>> On Sat, 2013-11-09 at 00:03 +0200, Anssi Hannula wrote:
>>> 08.11.2013 23:28, Olivier Langlois kirjoitti:
>>>> lano1106@whippet2 ~ $ speaker-test -D hdmi:CARD=HDMI,DEV=0 -c8 -r192000
>>>> -F S32_LE
>>>> 
>>>> speaker-test 1.0.27.2
>>>> 
>>>> Playback device is hdmi:CARD=HDMI,DEV=0
>>>> Stream parameters are 192000Hz, S32_LE, 8 channels
>>>> Using 16 octaves of pink noise
>>>> Rate set to 192000Hz (requested 192000Hz)
>>>> Buffer size range from 8 to 131072
>>>> Period size range from 4 to 65536
>>>> Using max buffer size 131072
>>>> Periods = 4
>>>> was set period_size = 32768
>>>> was set buffer_size = 131072
>>>>  0 - Front Left
>>>>  4 - Center
>>>>  1 - Front Right
>>>>  7 - Side Right
>>>>  7 - Side Right
>>>>  6 - Side Left
>>>>  6 - Side Left
>>>>  5 - LFE
[...]

OK, speaker-test bug (affecting all generic HDMI codecs).

This is triggered by the fact that the standard CEA/HDMI 8 channel
mapping contains RL/RR and RLC/RRC instead of SL/SR and RL/RR. I.e. what
one usually considers side speakers is RL/RR and then the rear speakers
are RLC/RRC (rear-left-center, rear-right-center).

Speaker-test tries to play back channels in the following order:
  0, /* Front Left  */
  4, /* Center      */
  1, /* Front Right */
  7, /* Side Right  */
  3, /* Rear Right  */
  2, /* Rear Left   */
  6, /* Side Left   */
  5, /* LFE         */

When it is time to play back Side Left/Right, speaker-test tries to look
for SL/SR in the chmap, but doesn't find it, so it just plays back
channels 6/7 which are actually "SL/SR" but with a different name (RL/RR).

When it becomes time to playback Rear Left/Right, speaker-test again
tries to find RL/RR in the chmap, and this time it does. However, of
course the chmap RL/RR corresponds to the HDMI/CEA RL/RR which is
traditionally SL/SR. So SL/SR is outputted again.

AFAICS the most straight-forward way to fix this is to check that the
chmap actually comprises of the assumed regular channels before trying
to apply the predefined playback order, and then fallback to playing
channels in-order 0-7 (maybe also provide a predefined ordering for the
CEA/HDMI 8ch chmap, though).
I can do that later, right now I'm too tired.


BTW, currently speaker-test always uses its own hardcoded channel
number=>name mappings for showing the channel name, unless a channel map
was manually specified. This is clearly wrong since there may be a
device-specific non-standard channelmap.

I can fix that as well, but of course that would mess up the output for
HDMI when this is not applied:
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=56cac413dd6d43af8355f5d1f90a199b540f73fc

So what to do, can we show wrong channel names on broken kernels or
should we wait a bit?
I guess that one really should be pushed to -stable in any case...


(There is also the question if we want to change the HDMI channel
mapping to appear as traditional side+rear instead of the CEA
rear+rearcenter. I don't have a strong preference on this so I'm fine
with status quo.)

-- 
Anssi Hannula
