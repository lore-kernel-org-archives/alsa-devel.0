From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Mon, 13 Oct 2014 12:58:21 +0200
Message-ID: <543BB04D.8000906@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C936260469
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 12:58:31 +0200 (CEST)
Received: by mail-wi0-f175.google.com with SMTP id d1so7061230wiv.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 03:58:31 -0700 (PDT)
In-Reply-To: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

One more thing:

On 07/10/14 17:16, David Henningsson wrote:
> +	/* initialize sampling rate to 48000 */
> +	err = set_ctl_urb2(mixer->chip, UAC2_CS_CUR, 0x0100, 0x29, "\x80\xbb\x00\x00", 4);
> +	if (err<  0)
> +		return err;
> +

There have been two reports of users that had to replace the 
set_ctl_urb2 line with:

    char buffer[4] = { '\x80', '\xbb', '\x00', '\x00' };
    err = set_ctl_urb2(mixer->chip, UAC2_CS_CUR, 0x0100, 0x29, buffer, 4);

otherwise they would get a kernel oops, e.g.:

   BUG: unable to handle kernel paging request at ffffffffa0b43440
   IP: [<ffffffff8136f3c2>] memcpy+0x12/0x110
   ...
   Call Trace:
     [<ffffffffa0b311d2>] ? snd_usb_ctl_msg+0xc2/0x160 [snd_usb_audio]
     [<ffffffffa0b3b7aa>] set_ctl_urb2+0xaa/0x100 [snd_usb_audio]
     [<ffffffffa0b3c9fa>] scarlett_mixer_controls+0x28a/0x4c0 
[snd_usb_audio]
   ...

I'm not sure, why this happen, and why only for very few users.
Maybe it has to do with a particular compiler, or some kernel config 
setting that places the bytes "somewhere else" when they are passed as 
string?

   Tobias
