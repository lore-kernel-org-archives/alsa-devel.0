From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How to close ALSA device nodes?
Date: Sun, 18 Oct 2009 11:13:15 -0600
Message-ID: <51f3faa70910181013r3a0e4f44n8673d9bad3ba2d43@mail.gmail.com>
References: <200910181906.25790.rem@videolan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f199.google.com (mail-iw0-f199.google.com
	[209.85.223.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E94D245D0
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 19:13:16 +0200 (CEST)
Received: by iwn37 with SMTP id 37so1808739iwn.16
	for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2009 10:13:15 -0700 (PDT)
In-Reply-To: <200910181906.25790.rem@videolan.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: remi@remlab.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/10/18 R=E9mi Denis-Courmont <rem@videolan.org>:
> =A0 =A0 =A0 =A0Hello,
>
> I'm getting a bug report against VLC media player whereby ALSA sound outp=
ut
> stops working when the screensaver is inhibited. It turns out that VLC is
> leaking any file descriptor open through ALSA-lib into child processes. T=
he
> exact same issue was already raised by mplayer... 6 years ago:
> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06249.html
>
> In other cases (V4L, OSS, DVB, DVD, sockets, even regular files...), VLC =
would
> open the device nodes with O_CLOEXEC flag (if supported by kernel and lib=
c)
> and fallback to setting FD_CLOEXEC via fcntl(). Then the descriptor is
> automatically, and in the earlier case, thread-safely, closed whenever VL=
C -
> forks and- execs. With ALSA-lib, I cannot figure any way to achieve that.=
..
>
> From the earlier thread, I reckon that ALSA developers consider that this=
 is
> an upper-layer issue. Maybe so, but then how is the upper-layer supposed =
to
> find which file descriptors ALSA-lib has opened - if any? Conversely, if =
ALSA-
> lib won't tell while file descriptors it is using, what could possibly be=
 the
> use case for not closing those on exec?

I agree that it's a difficult problem for an app that wants to fork
and exec another process.. I'd think really should be some way for an
app to control the CLOEXEC flag for the file descriptors that alsa-lib
has open..

I guess the alternative would be to shutdown all open PCMs, etc. in
ALSA in the child process after forking and before the exec, so that
they don't end up still open for the new process..
