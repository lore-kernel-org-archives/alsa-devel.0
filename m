From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: RFC: ice1712 virtual devices
Date: Sat, 21 Nov 2009 10:53:10 +0800
Message-ID: <4f3252890911201853s377dfbeaxb19c93af5a587b24@mail.gmail.com>
References: <4AE9D57E.5090105@hotmail.com>
	<200910300923.37295.gineera@aspect135.co.uk>
	<s5h3a4pqp1c.wl%tiwai@suse.de>
	<200911082113.17684.gineera@aspect135.co.uk>
	<4B01A8CC.6050303@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A3BEE2436F
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 03:53:11 +0100 (CET)
Received: by pzk9 with SMTP id 9so2640291pzk.16
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 18:53:10 -0800 (PST)
In-Reply-To: <4B01A8CC.6050303@hotmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pulseaudio fail when using front device of emu10k1 for capturing

I: module.c: Loaded "module-alsa-sink" (index: #0; argument: "device_id=0
sink_name=alsa_output.pci_1102_8_alsa_playback_0").
D: module-hal-detect.c: Loading module-alsa-source with arguments
'device_id=0 source_name=alsa_input.pci_1102_8_alsa_capture_0'
D: alsa-util.c: Trying front:0...
ALSA lib setup.c:96:(snd_sctl_install) Cannot *lock* *ctl* elem


Each front , rear and lfe_center playback subdevice has two ctl hook with
lock

EMU10K1.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks

	slave.pcm {
		type hw
		card $CARD
	}
	hooks.0 {
		type ctl_elems
		hook_args [

			{
				interface PCM
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				optional true
				value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
			}
			{

				# for compatibility with older drivers
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				optional true
				value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]

			}
			{
				interface PCM
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				optional true
				value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
			}
			{

				# for compatibility with older drivers
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				optional true
				value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
			}

		]
	}
}	



2009/11/17 Arno Schuring <aelschuring@hotmail.com>

> Hello again,
>
> Alan Horstmann wrote:
> > On Sunday 08 November 2009 10:38, you wrote:
> >> At Fri, 30 Oct 2009 09:23:37 +0000,
> >>
> >> Alan Horstmann wrote:
> >>> On Thursday 29 October 2009 17:48, Arno Schuring wrote:
> >>>> This is basically a resend of
> >>>> http://thread.gmane.org/gmane.linux.alsa.devel/59481/focus=59672 ,
> >>>> which fixed the front: device of ice1712 cards to accept two-channel
> >>>> input. Currently, the front: device is exposed through the route
> >>>> plugin, which requires all clients to mmap all 10 channels, even
> though
> >>>> the front device is supposed to be a stereo device.
> [...]
> >
> > Arno's original post was just to the list, so I added your cc.  His
> response
> > was also only to the list, but has a patch at the bottom to do just
> playback
> > asym with channels convertion, (which looks reasonable to me), so might
> be
> > worth looking back at.
> >
> > BTW, for example in the case of ice1712, is there a way for different
> sound
> > cards which use the same driver to have different default config files?
>  The
> > DMX6fire in particular would benefit from specific definitions for the
> > particular mapping of its 6 analogue inputs.
>
> I apologize for the long delay. I'll reattach my latest proposed patch
> (copy-paste, hope it still applies).
>
> About my second question, is it even worth my time to try to implement
> multiple separate devices using the dshare plugin? I mean, even if I
> succeed in making front: and spdif: working together, does such a patch
> have even the slightest of getting accepted?
>
>
> Thanks,
> Arno
>
>
> --
> diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
> index 01e50d2..1cd3773 100644
> --- a/src/conf/cards/ICE1712.conf
> +++ b/src/conf/cards/ICE1712.conf
> @@ -32,12 +32,16 @@ ICE1712.pcm.front.0 {
>         @args.CARD {
>                type string
>        }
> -       type route
> -       ttable.0.0 1
> -       ttable.1.1 1
> -       slave.pcm {
> -               type hw
> -               card $CARD
> +       type asym
> +       playback.pcm {
> +               type route
> +               ttable.0.0 1
> +               ttable.1.1 1
> +               slave.pcm {
> +                       type hw
> +                       card $CARD
> +               }
> +               slave.channels 10
>         }
>  }
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
