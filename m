From: "Xavi de Blas" <xaviblas@gmail.com>
Subject: Re: Intel hda ICH7 not worked anymore after using wine
Date: Mon, 9 Jul 2007 16:36:35 +0200
Message-ID: <256a87490707090736x224632b4j22c0019b674a42a0@mail.gmail.com>
References: <256a87490707090516s3126fa56g89f8624bd4351048@mail.gmail.com>
	<s5h3azxvke9.wl%tiwai@suse.de>
	<256a87490707090626o47383918u84db607c6753a5df@mail.gmail.com>
	<s5hmyy5u2je.wl%tiwai@suse.de>
	<256a87490707090658ia17c882h823d0f952968af5d@mail.gmail.com>
	<s5hd4z1mz0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 21608103885
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 16:36:39 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so637374nzf
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2007 07:36:39 -0700 (PDT)
In-Reply-To: <s5hd4z1mz0s.wl%tiwai@suse.de>
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

2007/7/9, Takashi Iwai <tiwai@suse.de>:
> At Mon, 9 Jul 2007 15:58:30 +0200,
> Xavi de Blas wrote:
> >
> > 2007/7/9, Takashi Iwai <tiwai@suse.de>:
> > > At Mon, 9 Jul 2007 15:26:59 +0200,
> > > Xavi de Blas wrote:
> > > >
> > > > Hello
> > > >
> > > > 2007/7/9, Takashi Iwai <tiwai@suse.de>:
> > > > > At Mon, 9 Jul 2007 14:16:43 +0200,
> > > > > Xavi de Blas wrote:
> > > > > >
> > > > > > Hello, I installed Wine on my Ubuntu Feisty on IBM-lenovo X60s, and
> > > > > > after reboot, sound never worked again.
> > > > > >
> > > > > > I tried to activate and to hide modem on the bios. I tried to stop
> > > > > > machine, take off battery, wait 10s, put battery again, and boot
> > > > > > without the power cable connected... and i tried lots of things from
> > > > > > ubuntuforums. I reinstalled feisty and sound doesn't work.
> > > > > >
> > > > > > I used alsa-info.sh script, here is the result:
> > > > > >
> > > > > > http://pastebin.ca/610317
> > > > >
> > > > > The codec isn't handled via the proper support code but only by the
> > > > > generic parser.  It won't work for Thinkpad.
> > > > >
> > > >
> > > > I'm not sure if i understood... then, no solution for me now?
> > > >
> > > > should i try the alsa svn code?
> > > >
> > > >
> > > > > > Should the new kernel 2.6.22 help me?
> > > > >
> > > > > X60 is known to work with recent kernels (but you'd better to give
> > > > > probe_mask=1 option to avoid the modem codec).
> > > > >
> > > >
> > > > I tried, rebooted and pastebin changed:
> > > > http://pastebin.ca/610387
> > > >
> > > > This doesn't exist now:
> > > > # Codec: Conexant ID 2bfa
> > > > # Address: 1
> > > > # Vendor Id: 0x14f12bfa
> > > > # Subsystem Id: 0x17aa201b
> > > > # Revision Id: 0x90000
> > >
> > > Err, it's a modem codec.  Pass probe_mask=2 instead, then.
> > >
> >
> > Now i have still no sound. But there's no messages about hda on dmesg
> >
> > $ dmesg | grep -i hda
> >
> > $ tail -2 /etc/modprobe.d/alsa-base
> > options snd-hda-intel probe_mask=2
> >
> > I commented the /etc/modprobe.d/snd-hda-intel.modprobe
> >
> > On pastebin:
> > http://pastebin.ca/610431
> >
> > The "HDA-Intel Codec information" changed a lot.
> >
> > Still any ideas?
>
> It's really from 2.6.22 kernel?  I won't debug 2.6.20 kernel drivers
> unless you build ALSA 1.0.14 driver from tarball separately.
>
> Once after upgrading 2.6.22 kernel, try at first without any module
> options for snd-hda-intel.  Check /proc/asound/card0/codec#* file (if
> any) whether it recogizes AD1981 codec.  If not, play with probe_mask
> option.  Once after the module gets loaded, then make sure that you
> unmuted / adjusted the mixer volumes.  Use aplay or speaker-test for
> testing.  Finally, if it still doesn't work, report again.
>


No, it's this kernel:
$ uname -a
Linux corall 2.6.20-16-generic #2 SMP Thu Jun 7 20:19:32 UTC 2007 i686 GNU/Linux

I asked about upgrading to 2.6.22, but i'm still on 2.6.20

But i built alsa 1.0.14 separately

My asound/card... is:

$ cat /proc/asound/card0/codec#*
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x17aa201b
Revision Id: 0x90000

If you can help me now, i will be glad, if not, i will try to upload
to 2.6.22 as soon as possible. Thanks

Xavi

>
> Takashi
>
