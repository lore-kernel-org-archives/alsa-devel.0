From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-driver git repo: Build problems when
 copying symlink to itself
Date: Mon, 14 Mar 2011 10:54:14 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103141051450.4805@eeebox2.perex-int.cz>
References: <ilfi0p$7hr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A83D10380E
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:54:15 +0100 (CET)
In-Reply-To: <ilfi0p$7hr$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Mar 2011, Colin Guthrie wrote:

> Hi,
>
> After doing a "simple":
> git clone alsa-driver
> git clone alsa-kernel
> cd alsa-driver
> ./gitcompile --with-debug=full --with-isapnp=yes --with-sequencer=yes
> --with-moddir=updates/alsa:
>
> The build bombed out pretty quickly with the following error.
>
> The attached patch fixes it.
>
> Hacking autoconf.h...
> make[1]: Entering directory
> `/home/colin/Development/Personal/ALSA/alsa-driver/include'
> make -C sound prepare
> make[2]: Entering directory
> `/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
> make prepare2
> make[3]: Entering directory
> `/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
> cp ../../alsa-kernel/include/ac97_codec.h .
> patch -p0 -i ac97_codec.patch ac97_codec.h
> patching file ac97_codec.h
> Hunk #1 succeeded at 650 (offset 5 lines).
> cp ../../alsa-kernel/include/core.h .
> patch -p0 -i core.patch core.h
> patching file core.h
> cp ../../alsa-kernel/include/info.h .
> cp: `../../alsa-kernel/include/info.h' and `./info.h' are the same file

I don't see this error using 'alsa-compile.sh --git' on Fedora 14... Make 
sure that the alsa-driver tree is clean before build.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
