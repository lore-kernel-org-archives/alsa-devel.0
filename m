From: "Xavi de Blas" <xaviblas@gmail.com>
Subject: Re: Intel hda ICH7 not worked anymore after using wine
Date: Mon, 9 Jul 2007 17:25:37 +0200
Message-ID: <256a87490707090825w550bc159tb3d3fba7fad3bd98@mail.gmail.com>
References: <256a87490707090516s3126fa56g89f8624bd4351048@mail.gmail.com>
	<s5h3azxvke9.wl%tiwai@suse.de>
	<256a87490707090626o47383918u84db607c6753a5df@mail.gmail.com>
	<s5hmyy5u2je.wl%tiwai@suse.de>
	<256a87490707090658ia17c882h823d0f952968af5d@mail.gmail.com>
	<s5hd4z1mz0s.wl%tiwai@suse.de>
	<256a87490707090736x224632b4j22c0019b674a42a0@mail.gmail.com>
	<s5hbqelmyd5.wl%tiwai@suse.de>
	<256a87490707090756h5ec226ddv63a081562808efc9@mail.gmail.com>
	<1183993639.9416.237.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B71E243A3
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 17:25:39 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1311636wag
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2007 08:25:37 -0700 (PDT)
In-Reply-To: <1183993639.9416.237.camel@razman.gruemaster.com>
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2007/7/9, Tobin Davis <tdavis@dsl-only.net>:
> Sorry for missing this thread.  I just woke up.
>
> I looked at your first pastebin output, and the actual audio codec shows
> up as 0x51d41981, when it should be 0x11d41981.  This is why the Analog
> driver patch isn't detecting it.
>
> Can you try this patch against alsa-driver-1.0.14?  It should detect
> this codec.  Still not sure why it is misconfigured, unless there is a
> bios issue.
>

I'm afraid, probably when i tried the Linuxant codecs for the modem it broke the
bios. Not sure, but sound worked, and continued working some reboots
later. But when i tried a few things with wine and rebooted, sound
never worked again

When i aply the patch (probably i don't do it good) there are problems:


xavier@corall:/usr/local/src/alsa-src/alsa-driver-1.0.14$ cat
LenovoX60S.patch | patch -p1
patching file pci/hda/patch_analog.c
Hunk #1 FAILED at 3402.
1 out of 1 hunk FAILED -- saving rejects to file pci/hda/patch_analog.c.rej


xavier@corall:/usr/local/src/alsa-src/alsa-driver-1.0.14/pci/hda$ cat
patch_analog.c.rej
*************** struct hda_codec_preset snd_hda_preset_a
*** 3402,3407 ****
       { .id = 0x11d41882, .name = "AD1882", .patch = patch_ad1882 },
       { .id = 0x11d41884, .name = "AD1884", .patch = patch_ad1884 },
       { .id = 0x11d41981, .name = "AD1981", .patch = patch_ad1981 },
       { .id = 0x11d41983, .name = "AD1983", .patch = patch_ad1983 },
       { .id = 0x11d41984, .name = "AD1984", .patch = patch_ad1984 },
       { .id = 0x11d41986, .name = "AD1986A", .patch = patch_ad1986a },
--- 3402,3408 ----
       { .id = 0x11d41882, .name = "AD1882", .patch = patch_ad1882 },
       { .id = 0x11d41884, .name = "AD1884", .patch = patch_ad1884 },
       { .id = 0x11d41981, .name = "AD1981", .patch = patch_ad1981 },
+       { .id = 0x51d41981, .name = "AD1981", .patch = patch_ad1981 },
       { .id = 0x11d41983, .name = "AD1983", .patch = patch_ad1983 },
       { .id = 0x11d41984, .name = "AD1984", .patch = patch_ad1984 },
       { .id = 0x11d41986, .name = "AD1986A", .patch = patch_ad1986a },


The patch is ok?

Thanks

(Tobin sorry for sending messge two times)
