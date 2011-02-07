From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: finally, ALSA 1.0.24 is out
Date: Mon, 7 Feb 2011 14:42:51 +0800
Message-ID: <AANLkTinW9nD4EAFPczAG47GGGKW4XEGx0BqSwLySR2v=@mail.gmail.com>
References: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3E59624602
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 07:42:53 +0100 (CET)
Received: by ewy19 with SMTP id 19so1929805ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Feb 2011 22:42:52 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/31 Jaroslav Kysela <perex@perex.cz>

> Hello all,
>
>        after very intensive testing, I released all ALSA packages with
> version number 1.0.24(+) :
>
>
when running alsa-driver 1.0.24 configure script

./configure --with-debug=verbose

why the script try to remove some system files ?

checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking for updating alsa-kernel version.h... yes
checking for CONFIG_EXPERIMENTAL... yes
rm: cannot remove `include/linux/usb/audio-v2.h': Permission denied
rm: cannot remove `include/linux/usb/audio.h': Permission denied
rm: cannot remove `include/trace/events/asoc.h': Permission denied
