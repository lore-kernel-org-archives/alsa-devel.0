From: "Marco Santamaria" <marco.santamaria@gmail.com>
Subject: Re: snd_usb_caiaq bug?
Date: Sat, 10 Jan 2009 13:53:24 +0100
Message-ID: <31e66c9e0901100453v326e585dx73b9079662a73006@mail.gmail.com>
References: <31e66c9e0901070741i2f6f363l9dc023223954ce2@mail.gmail.com>
	<907c05c70901071206y4bba38bej47f3eba51e6106d3@mail.gmail.com>
	<s5hy6xmhgp3.wl%tiwai@suse.de>
	<31e66c9e0901071659p63219af1wb392f50541cda7a0@mail.gmail.com>
	<31e66c9e0901071734t70c980a8t87f668f973b54635@mail.gmail.com>
	<s5h4p0at563.wl%tiwai@suse.de>
	<907c05c70901080626x83c3e2fn158d2938c4c8cbfd@mail.gmail.com>
	<s5h7i559845.wl%tiwai@suse.de>
	<20090108221153.GB31383@buzzloop.caiaq.de>
	<s5h8wpl3r6y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 771C11037EB
	for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2009 13:53:26 +0100 (CET)
Received: by bwz13 with SMTP id 13so26341611bwz.8
	for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2009 04:53:25 -0800 (PST)
In-Reply-To: <s5h8wpl3r6y.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <daniel@caiaq.org>, alsa-devel@alsa-project.org
Cc: Mysth-R <mysthr21@gmail.com>
List-Id: alsa-devel@alsa-project.org

During a Rosegarden session a qsampler crash caused the following output in
dmesg:

[11530.642970] qsampler[22794]: segfault at 00000008 eip b73f52c5 esp
bfe77e20 error 4
[13278.161113] ALSA
/home/marco/build/alsa-1.0.17/linux-2.6.24-23-rt/driver/alsa-driver-1.0.17/usb/caiaq/../../alsa-kernel/usb/caiaq/caiaq-midi.c:90:
snd-usb-caiaq log: snd_usb_caiaq_midi_send(f6d52b40): usb_submit_urb()
failed,ret=-22, len=61
[13720.859888] qjackctl.bin[22273]: segfault at 00000314 eip b7b07a7f esp
bfbe8f54 error 4

There are segmentation fault errors from qsampler and qjackctl, but perhaps
there's also a problem in caiaq-midi.c .

Regards,
Marco

2009/1/9 Takashi Iwai <tiwai@suse.de>

> At Thu, 8 Jan 2009 23:11:53 +0100,
> Daniel Mack wrote:
> >
> > Hi Takashi,
> >
> > On Thu, Jan 08, 2009 at 03:37:30PM +0100, Takashi Iwai wrote:
> > > > every thing is Ok for me now. No more crash, no more messages in
> dmesg.
> > > > I just had a warning during compilation, but I think this is not
> really
> > > > important :
> > > >
> > > > sound/usb/caiaq/caiaq-midi.c: In function
> \u2018snd_usb_caiaq_midi_output_done
> > > > \u2019:
> > > > sound/usb/caiaq/caiaq-midi.c:170: attention : unused variable
> \u2018buf\u2019
> > > >
> > > > Perhaps this is not the same line (170) as you but, in my file, it
> concerns
> > > > the last function.
> > >
> > > OK, it's simple to fix.
> > > The below is the latest version I committed now to sound git tree.
> > > It'll be pushed to 2.6.29 (and stable kernels) later.
> >
> > Thanks a lot for your help - I was on vacation until now and had very
> > limited ways to follow that thread. I would, however, apprectiate the
> > driver version number would be increased for this change, as it makes
> > tracking of user error reports better trackable.
> >
> > Do you want me to send in a patch for that or is it easier if you do
> > it yourself?
>
> I increased the version to 1.3.10 now.
>
>
> thanks,
>
> Takashi
>
