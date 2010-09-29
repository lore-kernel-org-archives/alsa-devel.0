From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixertest
Date: Wed, 29 Sep 2010 17:48:27 +0800
Message-ID: <AANLkTinb=+i7MfgYVYkA634aOK9xzvL6oEB1CtVnoJiW@mail.gmail.com>
References: <4CA30A13.2030802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 73BB81038D5
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 11:48:27 +0200 (CEST)
Received: by ewy21 with SMTP id 21so148632ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 02:48:27 -0700 (PDT)
In-Reply-To: <4CA30A13.2030802@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/29 David Henningsson <david.henningsson@canonical.com>

> Here's the tool "one of the Mandriva guys" ;-) was talking about the
> other day. I should probably have announced it on both lists
> simultaneously.
>
> Anyway, over the previous weeks I've been working on a small script
> which tests whether the ALSA mixer lives up to PA's expectations. If you
> are familiar with dbmeasure or dbverify by Lennart Poettering, this
> application's purpose is very similar, but this one is hopefully easier
> to set up, more user friendly, and also tests that the names of the
> volume controls are correct.
> My hope is that this will aid as a debugging tool for all these
> "everything below 20% of my speaker is muted, and then 21% blows my
> speakers" bugs.
>
> To use the tool, you'll need some kind of loopback. You can e g use a
> loopback cable and connect that between line in and line out, or test
> your laptop's internal speakers with your laptop's internal mic (just
> stop humming when you do so :-) ). Just set up the recording levels
> appropriately.
>
> Alsamixertest is available for Ubuntu Lucid and Ubuntu Maverick from
> these PPAs:
> Lucid: https://launchpad.net/~diwic/+archive/ppa<https://launchpad.net/%7Ediwic/+archive/ppa>
> Maverick: https://launchpad.net/~diwic/+archive/maverick<https://launchpad.net/%7Ediwic/+archive/maverick>
>
> For other distributions, download the tarball:
> https://launchpad.net/~diwic/+archive/ppa/+files/alsamixertest_47.14.tar.gz<https://launchpad.net/%7Ediwic/+archive/ppa/+files/alsamixertest_47.14.tar.gz>
> Unpack and read the readme file for compilation and install instructions.
>
> When it is installed, run "alsamixertest -r" for a small tutorial and
> "alsamixertest -h" for command line options help.
>
> Looking forward to your comments about this new little tool! I think it
> should be considered "beta" quality at this point.
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic <http://launchpad.net/%7Ediwic>
>

Do you need to write your own mixercontrol (amixer parser)  when there is
alsa-python mixercontrol ?
