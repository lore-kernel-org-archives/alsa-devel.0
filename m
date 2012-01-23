From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Request for compilation test - v1.0.25
Date: Mon, 23 Jan 2012 17:27:19 +0100
Message-ID: <4F1D8A67.3020909@canonical.com>
References: <4F1D405E.50301@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 48059103842
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 17:27:20 +0100 (CET)
In-Reply-To: <4F1D405E.50301@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/23/2012 12:11 PM, Jaroslav Kysela wrote:
> Hi all,
>
> 	I would like to ask for a package compilation test in your distribution
> for latest ALSA package snapshots available at:
>
> http://www.alsa-project.org/snapshot/

I have done a quick test compilation of these in the development version 
of Ubuntu, 12.04. So far, I did not test installing them.

>
> 	At this time, these snapshots are available:
>
> alsa-driver 	1.0.24.110.g22743.2525.ge60f5

Compiles without problems.

> alsa-lib 	1.0.24.1.53.g98d4e

Compiles without problems.

> alsa-utils 	1.0.24.2.26.g7d33a

Fails at configure (probably just requires headers from the alsa-lib 
snapshot)

http://paste.ubuntu.com/814406/

> alsa-firmware 	1.0.24.1.3.g3c38d

Compiles without problems.

> alsa-tools 	1.0.24.1.51.g234fa

Fails with:

configure.in:20: error: possibly undefined macro: AM_PATH_LD10K1

http://paste.ubuntu.com/814403/

Also, this package refuses to build in parallel (I'm running "make -j5").

> alsa-oss 	1.0.17.2.g1dfe1

Compiles without problems.

> alsa-plugins 	1.0.24.11.gb3fb5

Fails with:

make[2]: *** No rule to make target `50-pulseaudio.conf', needed by 
`all-am'.  Stop.

http://paste.ubuntu.com/814400/

> alsa-python 	1.0.24.2.g4c452

I'm not familiar with building python packages, but "python setup.py 
build" seems to compile without problems.

>
> 	Please, report any compilation/installation issues to this list (you
> may add CC to me). I am going to make 1.0.25 release on Wednesday.
>
> 	The alsa-driver package will not support the kernels bellow 2.6.18
> (released Sep 20 2006), from README:
>
>   - Vanilla 3.0 to 3.2
>   - Vanilla 2.6.18 to 2.6.39
>
> 	I kept the 2.4 build code, but it is not maintained and definitely, it
> will be removed in next alsa-driver versions.
>
> 				Jaroslav
>



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
