From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: can not access the alsa driver
Date: Thu, 10 Jan 2008 12:56:09 +0100
Message-ID: <1199966169.6073.30.camel@latc610.ft>
References: <48a1cba90801050642s47db1bcbj6c6624536eda5949@mail.gmail.com>
	<1199615384.5983.24.camel@md40100b.ft>
	<8b67d60801091335o67f7381dlb10648a4f15f4cbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.uni-ulm.de (mail.uni-ulm.de [134.60.1.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 18F6424527
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 12:58:01 +0100 (CET)
In-Reply-To: <8b67d60801091335o67f7381dlb10648a4f15f4cbf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ning Zhang <ning.zhang06@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Adrian,

On Wed, 2008-01-09 at 21:35 +0000, Adrian McMenamin wrote:
> > > Here are my questions:
> > > 1, When we install the alsa-lib, we can get some libs, besides those, do we
> > > also get some config files according to the local linux environment and
> > > alsa-lib will use these config files to access the real driver? If that, how
> > > can I install the alsa-lib to a embedded platform directly or what config
> > > files should I port to embedded platform?
> > >
> > > 2, Must I edit ~/.asoundrc and /etc/alsa/alsa.conf ? In my situation, what
> > > should I do ? Is somebody so kind can give me a simple template?
> >
> > I cannot really say something about your questions - I hadn't to create
> > any special config. files, when I started using my own driver (for a
> > PPC405 based board (ML403)). I just cross-compiled and installed
> > alsa-lib and alsa-tools (to have aplay and arecord).
> >
> Any chance you could publish your configuration here?

Well, I had _not_ to create any extra/additional config files.

- I fetched alsa-lib and alsa-tools source packages (at that time I used
1.0.13 and later 1.0.14).
- I used ELDK 4.0 for PPC405 as cross-compiler environment. <rootdir> is
the root directory used by the ML403 board.
- Compiled alsa-lib:
   $ ./configure --host=powerpc-linux
   $ make
   $ make DESTDIR=<rootdir> install
- Compiled alsa-tools (linked against alsa-lib)
   $ ./configure --host=powerpc-linux \
     --with-alsa-inc-prefix=<rootdir>/usr/include \
     --with-alsa-prefix=<rootdir>/usr/lib
   $ make
   $ make DESTDIR=<rootdir> install
- Login to board, modprobe my driver
- Make sure udev is running and created /dev/snd/* files OR
  - Create /dev/snd/* files with snddevices script from alsa-tools
package
- alsamixer (adjust volume), aplay somefile.wav

So, that's it - but I'm afraid that this won't help you. I never touched
any files installed by "make install" of both packages.

 Joachim
