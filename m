From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: aplay doesnt work - new problem`
Date: Wed, 12 Mar 2008 11:49:45 -0700
Message-ID: <61445c750803121149t45f1db2m69cce8d76fca213f@mail.gmail.com>
References: <61445c750803111605u1c9b8f5ascdee2289c992488a@mail.gmail.com>
	<47D7957D.2050505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 087572432F
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 19:49:49 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id r23so1917377elf.21
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 11:49:46 -0700 (PDT)
In-Reply-To: <47D7957D.2050505@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 12, 2008 at 1:34 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Pharaoh . wrote:
> > I am trying to run my pcm external io type plugin on an arm based board.
> I
> > have no kernel alsa driver
> > and the user space plugin is supposed to take care of talking to DSP
> using
> > shared memorty and send sound data.
> >
> > Since, I dont have kernel space ALSA driver, do I need to enable kernel
> ALSA
> > support in .config?
>
> No.
>
> > ALSA lib conf.c:2852:(snd_config_hook_load) cannot access file
> > /home/pharaoh/alsa/cards/aliases.conf
>
> What --*prefix options did you use when configuring alsa-lib?
> What did you use as DESTDIR when installing alsa-lib?
>
>
> Regards,
> Clemens
>

I configure alsa lib as :

./configure --host=$(ARCH_TOOLCHAIN_PREFIX)-linux --prefix=$(BUILD_OUTPUT)
--exec-prefix=$(ROOTFS) --datadir=$(ROOTFS)/share --sysconfdir=$(ROOTFS)/etc
--with-versioned=no --enable-static=yes

Ignore $(ARCH_TOOLCHAIN_PREFIX)-linux.
ROOTFS in / on board.
DESTDIR is is /lib in rootfs, this is where libasound.so falls.

But when I do file on resulting libasound.so it is shown as shared lib and
not a static one.

Same way I configure the alsa-utils.

-pharaoh.
