From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: developing audio with ALSA
Date: Mon, 18 Aug 2008 11:34:40 +0100
Message-ID: <g8bj80$fmd$1@ger.gmane.org>
References: <000e01c90112$e89e7e30$ba3ea8c0@Richwave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 740F91037FB
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 12:34:53 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KV24W-0008HM-C3
	for alsa-devel@alsa-project.org; Mon, 18 Aug 2008 10:34:48 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2008 10:34:48 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2008 10:34:48 +0000
In-Reply-To: <000e01c90112$e89e7e30$ba3ea8c0@Richwave.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henry Ho wrote:
> Hi
> 
> After reading the cross-compilation instruction in INSTALL file, 
> I already successfully configured the alsa-lib-2.0.17. I also 
> successfully made the library. Adding --prefix=xxx during 
> configuration can set the output directory to xxx.
> 
> I also modify my Makefile for application, including the search 
> path of libasound.so.2.***. Now I can successfully make it.
> 
> However, when I run my application on the target, I got the following 
> error message:
> 
> ******************************************************************************************
> ./pcm: error while loading shared libraries: libasound.so.2: cannot open 
> shared object file: No such file or directory
> ******************************************************************************************
> 
> I have put libasound.so.2.0.0 in /tmp of the target. I also modified 
> /etc/ld.so.conf, adding /tmp in ld.so.conf file. However, I cannot 
> find ldconfig on the target. Is anyone can tell me how to solve it?
> Should I rebuild a busybox with this command?

I'm wondering if you are mixing up --prefix and DESTDIR...

--prefix is the location that should be the *running systems* path on 
normal use. Even if you have a folder on your development machine that 
is different to that. e.g. say you are booting from compact flash: on 
your dev machine this may be mounted as /media/cf, but when you use it 
to boot it is actually the / of that system.

In this case I'd recommend you do:
./configure --prefix=/usr ....
make
sudo make DESTDIR=/media/cf install

That will install things in /media/cf.

You then need to modify other parts of your build to look in /media/cf 
for stuff and to strip out /media/cf from the linking, but that's 
another story.


All that said, I'd imagine you just didn't copy the symlinks that 
accoumpany the file libasound.so.2.0.0 ... it should come sith some 
symlinks that give it the name libasound.so.2 as well. (i.e. 
libasound.so.2 is a symlink to libasound.so.2.0.0)


Col
