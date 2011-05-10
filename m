From: Tim Blechmann <tim@klingt.org>
Subject: hdspmixer/ubuntu
Date: Tue, 10 May 2011 11:39:55 +0200
Message-ID: <iqb15b$hrl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C9001038D9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 11:40:12 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QJjQH-0004og-Rv
	for alsa-devel@alsa-project.org; Tue, 10 May 2011 11:40:09 +0200
Received: from 85-127-16-189.dynamic.xdsl-line.inode.at ([85.127.16.189])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2011 11:40:09 +0200
Received: from tim by 85-127-16-189.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2011 11:40:09 +0200
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

hi all,

the current version of ubuntu ships alsa-tools without hdspmixer [1], probably 
because of the problems of older versions with newer kernels (iirc a hardcoded 
preprocessor definition made the old version unusable). while it is still 
possible to compile a working hdspmixer from sources, this is quite inconvenient 
(especially for newbies).

questions:
- is there a plan to release a 1.0.24.2, including the hdspmixer fixes?

- gitcompile currently does not work on ubuntu, but requires this patch [2] in 
order to run the autotools. according to the name, it is already required for 
older versions 

- compiling ld10k1 fails with:
make[1]: Entering directory `/home/tim/workspace/alsa-tools/ld10k1'
Making all in setup
make[2]: Entering directory `/home/tim/workspace/alsa-tools/ld10k1/setup'
Making all in effects
make[3]: Entering directory `/home/tim/workspace/alsa-
tools/ld10k1/setup/effects'
make[3]: *** No rule to make target `simple.emu10k1', needed by `all-am'.  Stop.
  is this a problem on my side?

thanks, tim

[1] https://bugs.launchpad.net/ubuntu/+source/alsa-tools/+bug/723276
[2] http://svnweb.mageia.org/packages/cauldron/alsa-tools/current/SOURCES/alsa-
tools-1.0.11-gtk-buildfix.patch?view=log&pathrev=1611

-- 
tim@klingt.org
http://tim.klingt.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
