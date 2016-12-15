From: Manohar Narkhede <Manohar.Narkhede@imgtec.com>
Subject: Re: [PATCH - alsa-lib 1/1] conf/cards: add support for
 pistachio-card.
Date: Thu, 15 Dec 2016 07:27:01 +0000
Message-ID: <4C4BBC670645CD40A5DCE76BCEA29FD2DAB09BC4@PUMAIL01.pu.imgtec.org>
References: <1480325591-4681-1-git-send-email-manohar.narkhede@imgtec.com>
 <s5hh96r8ztv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1923B266801
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 08:27:08 +0100 (CET)
In-Reply-To: <s5hh96r8ztv.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

We are adding new platform Creator Ci40 in OpenWRT and have pull request https://github.com/openwrt/openwrt/pull/201 for that. The data sheet of the chip and technical reference manual can be found at https://docs.creatordev.io/ci40/guides/hardware/#-cxt200-datasheet-hardwaredocs-cxt200_datasheet2-pdf- and https://docs.creatordev.io/ci40/guides/hardwaredocs/cXT200_datasheet2.pdf. 

The board configuration as per below:

root@OpenWrt:/# arecord -l
**** List of CAPTURE Hardware Devices **** card 0: pistachiocard [pistachio-card], device 1: pistachio-spdif-in snd-soc-dummy-dai-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: pistachiocard [pistachio-card], device 4: pistachio-i2s-in-0 snd-soc-dummy-dai-4 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


root@OpenWrt:/# aplay -l
**** List of PLAYBACK Hardware Devices **** card 0: pistachiocard [pistachio-card], device 0: pistachio-spdif-out snd-soc-dummy-dai-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: pistachiocard [pistachio-card], device 2: pistachio-parallel-out pistachio_internal_dac-2 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: pistachiocard [pistachio-card], device 3: pistachio-i2s-out snd-soc-dummy-dai-3 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


I tried to use dnsloop but was not able to get it working.

Thanks,
Manohar

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Monday, November 28, 2016 7:35 PM
To: Manohar Narkhede
Cc: alsa-devel@alsa-project.org; Manohar Narkhede
Subject: Re: [PATCH - alsa-lib 1/1] conf/cards: add support for pistachio-card.

On Mon, 28 Nov 2016 10:33:11 +0100,
<manohar.narkhede@imgtec.com> wrote:
> 
> From: Manohar Narkhede <Manohar.Narkhede@imgtec.com>
> 
> Signed-off-by: Manohar Narkhede <Manohar.Narkhede@imgtec.com>

Could you give a bit more information?
The configuration you gave isn't very straightforward, something really special.

> diff --git a/src/conf/cards/Makefile.am b/src/conf/cards/Makefile.am 
> index 008d399..60b5309 100644
> --- a/src/conf/cards/Makefile.am
> +++ b/src/conf/cards/Makefile.am
> @@ -39,6 +39,7 @@ cfg_files = aliases.conf \
>  	Maestro3.conf \
>  	NFORCE.conf \
>  	PC-Speaker.conf \
> +	pistachio-card.conf \
>  	PMac.conf \
>  	PMacToonie.conf \
>  	PS3.conf \
> diff --git a/src/conf/cards/aliases.conf b/src/conf/cards/aliases.conf 
> index 4a92fb2..60f9d26 100644
> --- a/src/conf/cards/aliases.conf
> +++ b/src/conf/cards/aliases.conf
> @@ -55,6 +55,7 @@ AV100 cards.CMI8788
>  AV200 cards.CMI8788
>  CMI8786 cards.CMI8788
>  CMI8787 cards.CMI8788
> +pistachio cards.pistachio-card
>  
>  <confdir:pcm/default.conf>
>  <confdir:pcm/dmix.conf>
> diff --git a/src/conf/cards/pistachio-card.conf 
> b/src/conf/cards/pistachio-card.conf
> new file mode 100644
> index 0000000..9c0318d
> --- /dev/null
> +++ b/src/conf/cards/pistachio-card.conf
> @@ -0,0 +1,34 @@
> +#
> +# Configuration for the pistachio chip #
> +
> +pistachio-card.pcm.default{
> +        @args [ CARD ]
> +        @args.CARD {
> +                type string
> +                default "pistachio"
> +        }
> +        @args.DEVICE {
> +                type integer
> +                default 2
> +        }
> +
> +        type asym
> +        capture.pcm {
> +                type multi
> +                slaves.a.pcm "hw:0,4"
> +                slaves.a.channels 12
> +                bindings.0.slave a
> +                bindings.0.channel 4
> +                bindings.1.slave a
> +                bindings.1.channel 5
> +        }

So for the capture, we always ignore $DEVICE but use the fixed one, right?

And, for the configuration, the multi plugin is superfluous.  It has only one slave, so it can be a simple route plugin.  But...

> +
> +        playback.pcm {
> +                type hw
> +                card $CARD
> +                device $DEVICE
> +
> +        }

... this is the hw plugin.  And it means that the "default" PCM won't work with any other configuration.  We usually wrap it with plug plugin.

Also, most of other configuration allow the multiplexing via dmix and dsnoop.  I don't know whether these would work for your systems, but by defining the like above, the access will be exclusive.
If this is per design, it must be explained in the comments or in the commit log (at best in both).


thanks,

Takashi
