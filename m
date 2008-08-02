From: "Marco Schuster" <marco@harddisk.is-a-geek.org>
Subject: Re: ultra small alsa library
Date: Sat, 2 Aug 2008 22:34:22 +0200
Message-ID: <b542c8b90808021334t48de6d9bta9a6678a5838580@mail.gmail.com>
References: <b542c8b90808020738g76115165ve9d2d02a033706bf@mail.gmail.com>
	<87tze3tlbw.fsf@free.fr>
	<b542c8b90808021214s2ccb1ec1h5d5106e6c2cdd0ae@mail.gmail.com>
	<b542c8b90808021333r71111c26l96fa0961ea8d879f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 857D3246F3
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Aug 2008 22:34:23 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id b32so1546443ika.0
	for <alsa-devel@alsa-project.org>; Sat, 02 Aug 2008 13:34:22 -0700 (PDT)
In-Reply-To: <b542c8b90808021333r71111c26l96fa0961ea8d879f@mail.gmail.com>
Content-Disposition: inline
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

The problem I have is:
As soon as I try to play a mp3 via mpg123, in dmesg comes the following
error:
Division by zero in kernel.
[<c0026e2c>] (dump_stack+0x0/0x14) from [<c0026e58>] (__div0+0x18/0x20)
[<c0026e40>] (__div0+0x0/0x20) from [<c011c65c>] (Ldiv0+0x8/0x10)
[<bf0267ec>] (iso_stream_find+0x0/0x340 [ehci_hcd]) from [<bf028140>]
(ehci_urb_enqueue+0x848/0xdf4 [ehci_hcd])
[<bf0278f8>] (ehci_urb_enqueue+0x0/0xdf4 [ehci_hcd]) from [<bf005228>]
(usb_hcd_submit_urb+0x660/0x77c [usbcore])
[<bf004bc8>] (usb_hcd_submit_urb+0x0/0x77c [usbcore]) from [<bf0057fc>]
(usb_submit_urb+0x228/0x264 [usbcore])
[<bf0055d4>] (usb_submit_urb+0x0/0x264 [usbcore]) from [<bf1c2820>]
(start_urbs+0x1cc/0x308 [snd_usb_audio])
 r6:00000000 r5:c0c2dc10 r4:00000010
[<bf1c2654>] (start_urbs+0x0/0x308 [snd_usb_audio]) from [<bf1c4d78>]
(snd_usb_pcm_prepare+0xa4/0xb8 [snd_usb_audio])
 r7:00000000 r6:00000000 r5:c0c2b800 r4:c0c2dc10
[<bf1c4cd4>] (snd_usb_pcm_prepare+0x0/0xb8 [snd_usb_audio]) from
[<bf19bdc4>] (snd_pcm_do_prepare+0x1c/0x3c [snd_pcm])
 r6:00000802 r5:c13d02c0 r4:c13d02c0
[<bf19bda8>] (snd_pcm_do_prepare+0x0/0x3c [snd_pcm]) from [<bf19b96c>]
(snd_pcm_action_single+0x40/0x7c [snd_pcm])
 r4:bf1acd74
[<bf19b92c>] (snd_pcm_action_single+0x0/0x7c [snd_pcm]) from [<bf19c774>]
(snd_pcm_action_nonatomic+0x58/0x70 [snd_pcm])
 r7:00044930 r6:bf1acd74 r5:00000802 r4:c13d02c0
[<bf19c71c>] (snd_pcm_action_nonatomic+0x0/0x70 [snd_pcm]) from [<bf19eba8>]
(snd_pcm_common_ioctl1+0x664/0xf7c [snd_pcm])
 r6:c13d02c0 r5:00044930 r4:00044930
[<bf19e544>] (snd_pcm_common_ioctl1+0x0/0xf7c [snd_pcm]) from [<bf19fe18>]
(snd_pcm_playback_ioctl1+0x48c/0x4b0 [snd_pcm])
[<bf19f98c>] (snd_pcm_playback_ioctl1+0x0/0x4b0 [snd_pcm]) from [<bf19ff20>]
(snd_pcm_playback_ioctl+0x34/0x40 [snd_pcm])
[<bf19feec>] (snd_pcm_playback_ioctl+0x0/0x40 [snd_pcm]) from [<c0097e70>]
(do_ioctl+0x34/0x78)
[<c0097e3c>] (do_ioctl+0x0/0x78) from [<c0098114>] (vfs_ioctl+0x260/0x290)
 r5:00044930 r4:c0fbcbc0
[<c0097eb4>] (vfs_ioctl+0x0/0x290) from [<c009819c>] (sys_ioctl+0x58/0x78)
 r7:00004140 r6:c0fbcbc0 r5:00044930 r4:00000000
[<c0098144>] (sys_ioctl+0x0/0x78) from [<c0022de0>]
(ret_fast_syscall+0x0/0x2c)
 r8:c0022f84 r7:00000036 r6:beebb3a0 r5:beebb708 r4:00043598


Can anyone point me what goes wrong here?
Kernel is debian  2.6.24-1-ixp4xx (armv5tel).

Thanks,
Marco
