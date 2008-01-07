From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Cross compiling alsa-lib (again)
Date: Sun, 6 Jan 2008 21:15:08 -0500
Message-ID: <75b66ecd0801061815t4c8817c6q7edb77fae2b2e02b@mail.gmail.com>
References: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id AA0DF10386B
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 03:15:12 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so4686260rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 06 Jan 2008 18:15:08 -0800 (PST)
In-Reply-To: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
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
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Jan 6, 2008 6:42 PM, Adrian McMenamin <lkmladrian@gmail.com> wrote:
> I admit to not using the additional cflags stuff before, but even if I use this:
>
> CFLAGS="-Os -m4 -ml" ./configure --host=sh4-linux --prefix=/usr
> CC=/home/adrian/dreamy-linux/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
> --disable-python --disable-rawmidi --enable-static
> --with-confdir=/home/adrian/dreamy-linux/buildroot/project_build_sh4/dreamcast/root/usr/share/alsa
>  --disable-mixer --enable-static=yes --enable-shared=no
> --target=sh4-linux --build=i686-linux
>

What if you omit the --confdir arg?

Lee
