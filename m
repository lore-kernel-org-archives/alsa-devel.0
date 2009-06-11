From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted:
Date: Thu, 11 Jun 2009 14:42:48 +0200
Message-ID: <4A30FBC8.2010907@googlemail.com>
References: <20090610231400.511367190d6e5c5c661eac68a9a86d95.17a4937c08.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AA9424651
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 14:42:50 +0200 (CEST)
Received: by fxm18 with SMTP id 18so1485903fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 05:42:49 -0700 (PDT)
In-Reply-To: <20090610231400.511367190d6e5c5c661eac68a9a86d95.17a4937c08.wbe@email.secureserver.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: bill@tellytopia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

bill@tellytopia.com schrieb:
> I am using the snd-ctxfi driver on a 64-bit version of fedora code 7.
> Is there anyone else working on a 64-bit system?
Yes, me!
Gentoo Linux x86_64-pc-linux-gnu
Kernel 2.6.29-gentoo-r5

> There are some compile warnings during the compilation of the driver,
> but no errors.
Here are the Warnings I get:
/usr/src/alsa-driver/acore/sound.c: In function 'snd_request_other':
/usr/src/alsa-driver/acore/sound.c:99: warning: format not a string
literal and no format arguments

/usr/src/alsa-driver/acore/seq/seq_clientmgr.c: In function
'snd_seq_info_dump_subscribers':
/usr/src/alsa-driver/acore/seq/seq_clientmgr.c:2465: warning: format not
a string literal and no format arguments

So... Nothing serious...

> But no sound, either, so far.
Did you try "modprobe snd_ctxfi"?
Did you unmute all needed Channels?

> I have also taken the 1.0.20 library, utils and tools sources from the
> Alsa main downloads.
My versions (if it helps):
media-libs/alsa-lib-1.0.18
media-sound/alsa-utils-1.0.18

Both normally installed through packet management a while ago (when
installing the system)

> Any ideas, anyone?
Sorry, only one:
Try loading the module "snd_ctxfi" manually.
Does this work? Any errors? dmesg-output?

-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
