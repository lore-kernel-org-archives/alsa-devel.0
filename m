From: "Xavi de Blas" <xaviblas@gmail.com>
Subject: Re: Intel hda ICH7 not worked anymore after using wine
	(SOLVED!)
Date: Tue, 10 Jul 2007 16:03:48 +0200
Message-ID: <256a87490707100703x25f20e25p83db0169d03c0d5d@mail.gmail.com>
References: <256a87490707090958w39a1aa3epb38dc61fde92fb68@mail.gmail.com>
	<1184000657.27029.15.camel@razman.gruemaster.com>
	<s5hsl7wli4i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 804F91038D3
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 16:03:51 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1733469wag
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 07:03:49 -0700 (PDT)
In-Reply-To: <s5hsl7wli4i.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Then you think it's a problem of my bios?

I read about a bug named "no sound after windows". I don't know i if it's my bug

Thanks

2007/7/10, Takashi Iwai <tiwai@suse.de>:
> At Mon, 09 Jul 2007 10:04:17 -0700,
> Tobin Davis wrote:
> >
> > Then I humbly sign off on that patch.
> >
> > For the record:
> >
> > Summary:  HDA - patch to fix issue with Lenovo Thinkpad codec ID.
> >
> > This patch fixes an issue in Lenovo Thinkpads where the codec ID gets changed.
> >
> > Signed off by Tobin Davis <tdavis@dsl-only.net>
>
> Well, I don't think this is a generic problem, so let's keep it out of
> the upstream for now.  Maybe I'll rethink if the same problem occurs
> to anyone else, too...
>
>
> Takashi
>
> >
> > On Mon, 2007-07-09 at 18:58 +0200, Xavi de Blas wrote:
> >
> >     It worked!!!
> >
> >     Thanks a lot
> >
> >     I thought my hardware was broken!
> >
> >     2007/7/9, Tobin Davis <tdavis@dsl-only.net>:
> >
> >         Patch needs to be applied as follows:
> >
> >             cd alsa-driver-1.0.14/alsa-kernel
> >             patch -p1 < LenovoX60S.patch
> >             cd ..
> >
> >         Then you can rerun configure && make && make install.
> >
> >         Tobin
> >
> >         On Mon, 2007-07-09 at 17:25 +0200, Xavi de Blas wrote:
> >
> >             2007/7/9, Tobin Davis <tdavis@dsl-only.net>:
> >             > Sorry for missing this thread.  I just woke up.
> >             >
> >             > I looked at your first pastebin output, and the actual audio codec shows
> >             > up as 0x51d41981, when it should be 0x11d41981.  This is why the Analog
> >             > driver patch isn't detecting it.
> >             >
> >             > Can you try this patch against alsa-driver-1.0.14?  It should detect
> >             > this codec.  Still not sure why it is misconfigured, unless there is a
> >             > bios issue.
> >             >
> >
> >             I'm afraid, probably when i tried the Linuxant codecs for the modem it broke the
> >             bios. Not sure, but sound worked, and continued working some reboots
> >             later. But when i tried a few things with wine and rebooted, sound
> >             never worked again
> >
> >             When i aply the patch (probably i don't do it good) there are problems:
> >
> >             xavier@corall:/usr/local/src/alsa-src/alsa-driver-1.0.14$ cat
> >             LenovoX60S.patch | patch -p1
> >             patching file pci/hda/patch_analog.c
> >             Hunk #1 FAILED at 3402.
> >             1 out of 1 hunk FAILED -- saving rejects to file pci/hda/patch_analog.c.rej
> >
> >             xavier@corall:/usr/local/src/alsa-src/alsa-driver-1.0.14/pci/hda$ cat
> >             patch_analog.c.rej
> >             *************** struct hda_codec_preset snd_hda_preset_a
> >             *** 3402,3407 ****
> >                    { .id = 0x11d41882, .name = "AD1882", .patch = patch_ad1882 },
> >                    { .id = 0x11d41884, .name = "AD1884", .patch = patch_ad1884 },
> >                    { .id = 0x11d41981, .name = "AD1981", .patch = patch_ad1981 },
> >                    { .id = 0x11d41983, .name = "AD1983", .patch = patch_ad1983 },
> >                    { .id = 0x11d41984, .name = "AD1984", .patch = patch_ad1984 },
> >                    { .id = 0x11d41986, .name = "AD1986A", .patch = patch_ad1986a },
> >             --- 3402,3408 ----
> >                    { .id = 0x11d41882, .name = "AD1882", .patch = patch_ad1882 },
> >                    { .id = 0x11d41884, .name = "AD1884", .patch = patch_ad1884 },
> >                    { .id = 0x11d41981, .name = "AD1981", .patch = patch_ad1981 },
> >             +       { .id = 0x51d41981, .name = "AD1981", .patch = patch_ad1981 },
> >                    { .id = 0x11d41983, .name = "AD1983", .patch = patch_ad1983 },
> >                    { .id = 0x11d41984, .name = "AD1984", .patch = patch_ad1984 },
> >                    { .id = 0x11d41986, .name = "AD1986A", .patch = patch_ad1986a },
> >
> >             The patch is ok?
> >
> >             Thanks
> >
> >             (Tobin sorry for sending messge two times)
> >
> >         --
> >         Tobin Davis <tdavis@dsl-only.net>
> >
> > --
> > Tobin Davis <tdavis@dsl-only.net>
> >
> >
>
