From: robert.devanna@nospammail.net
Subject: Re: After kernel upgrade to v ~~> 4.1.0, no audio
 output unless UNPLUG/RE-PLUGIN of audio jack on card;
 OK with earlier kernels
Date: Mon, 06 Jul 2015 06:02:32 -0700
Message-ID: <1436187752.2309507.316261945.0F8FA636@webmail.messagingengine.com>
References: <1436128748.1442900.315748449.28688C30@webmail.messagingengine.com>
 <s5hfv518yhp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id B0C4E2605C7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:02:34 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 2826520A4C
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 09:02:33 -0400 (EDT)
In-Reply-To: <s5hfv518yhp.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Mon, Jul 6, 2015, at 01:46 AM, Takashi Iwai wrote:
> The most important bit wasn't shown in the mail -- the codec name.
>
> It's a known problem with VIA codecs, and the fix was already merged
> in 4.2-rc1, the commit 735c75cf4d434862e38c01dcfb2ce8d2fcb9035f.
> The next stable 4.1.x kernel should contain the fix.

I didn't realize the script wouldn't grab the important info needed.

I think this does say it's a VIA codec here?

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 3: VT1708S Digital [VT1708S Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

cat /proc/asound/card0/codec* | grep Codec
Codec: VIA VT1708S
