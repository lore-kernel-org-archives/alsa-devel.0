From: Stephane Alnet <alsa-dev@shimaore.net>
Subject: Re: snd-usb-audio: quirk for Edirol UA-5 in Advanced Mode
Date: Wed, 11 Jun 2003 22:50:50 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306112244350.10270-100000@kani-keli.alnet.home>
References: <Pine.LNX.4.44.0306102307170.26166-200000@kani-keli.alnet.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306102307170.26166-200000@kani-keli.alnet.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The error is as follows; I've tried to move a couple locks around but I
can't figure it out.

------------------------------------------>8
bad: scheduling while atomic!
Call Trace:
 [<c0116c26>] schedule+0x3a6/0x3b0
 [<c0121eda>] schedule_timeout+0x5a/0xb0
 [<c0121e70>] process_timeout+0x0/0x10
 [<d08afaff>] usb_start_wait_urb+0xaf/0x190 [usbcore]
 [<c0116c80>] default_wake_function+0x0/0x30
 [<d08af72f>] usb_alloc_urb+0x2f/0x50 [usbcore]
 [<d08afc47>] usb_internal_control_msg+0x67/0x80 [usbcore]
 [<d08afcee>] usb_control_msg+0x8e/0xb0 [usbcore]
 [<d08b088d>] usb_set_interface+0xbd/0x220 [usbcore]
 [<d08af2a0>] hcd_endpoint_disable+0x0/0x1c0 [usbcore]
 [<d0960591>] set_format+0xd1/0x3a0 [snd_usb_audio]
 [<d09608c4>] snd_usb_pcm_prepare+0x34/0x50 [snd_usb_audio]
 [<d0948f25>] snd_pcm_do_prepare+0x15/0x40 [snd_pcm]
 [<c013ecc2>] handle_mm_fault+0xe2/0x180
 [<d09483a4>] snd_pcm_action_single+0x34/0x60 [snd_pcm]
 [<d095cbe8>] snd_pcm_action_prepare+0x0/0x18 [snd_pcm]
 [<d09484e6>] snd_pcm_action_lock_irq+0x96/0xa0 [snd_pcm]
 [<d095cbe8>] snd_pcm_action_prepare+0x0/0x18 [snd_pcm]
 [<d0948ff4>] snd_pcm_prepare+0x74/0x90 [snd_pcm]
 [<d095cbe8>] snd_pcm_action_prepare+0x0/0x18 [snd_pcm]
 [<d094bd00>] snd_pcm_playback_ioctl1+0x70/0x430 [snd_pcm]
 [<c0121bc0>] run_timer_softirq+0x100/0x1a0
 [<c015e280>] sys_ioctl+0x100/0x290
 [<c010930b>] syscall_call+0x7/0xb
------------------------------------------>8

Stephane


On Tue, 10 Jun 2003, Stephane Alnet wrote:
> Hi,
>
> (Hopefully this is the right place to post this!)
>
> Attached is a diff file for the Edirol UA-5 Advanced Mode against kernel
> 2.5.70-bk14 sound/usb.
>
> I added a new QUIRK mode (QUIRK_AUDIOSTREAM_INTERFACE) which basically
> forces an interface (and its altsettings) into Audio/AudioStream. When in
> Advanced Mode, the UA-5 exposes all its interfaces in class 255/255
> (Vendor/Vendor), but actually besides this all the descriptors are valid
> USB Audio control/interfaces/endpoints/... So this quirk simply overwrites
> the streaming interfaces class/subclass with the proper values. (My
> understanding is that we don't need to care about the audiocontrol
> interface.)
>
> Recording is working properly (tested with "arecord -c 2 -f S24_3LE -r
> 96000" on x86, for example); playback is crashing due to a "bad:
> scheduling while atomic!" problem I haven't looked at yet.
>
> (Note: this change only applies to Advanced Mode, which provides access to
> 24bits samples and the 96kHz sampling rates. The non-Advanced Mode of the
> UA-5 works just fine with the default driver at 44.1 and 48kHz, giving
> 16bits samples, as far as I can tell.)
>
> Feel free to integrate the diff into the current distribution/kernel as
> needed.
>
> I'd be interested in feedback on whether this is working for other people,
> and also help in troubleshooting the playback crash.
>
> Thank you,
> Stephane




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
