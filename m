From: Tim Blechmann <tim@klingt.org>
Subject: Re: hdspmixer/ubuntu
Date: Thu, 12 May 2011 13:03:37 +0200
Message-ID: <iqgeqa$9sc$1@dough.gmane.org>
References: <iqb15b$hrl$1@dough.gmane.org>
	<20110512083620.GQ24348@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 763FA10382B
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 13:03:57 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QKTgR-0003YR-1E
	for alsa-devel@alsa-project.org; Thu, 12 May 2011 13:03:55 +0200
Received: from 85-127-249-139.dynamic.xdsl-line.inode.at ([85.127.249.139])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 13:03:55 +0200
Received: from tim by 85-127-249-139.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 13:03:55 +0200
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

>> - gitcompile currently does not work on ubuntu, but requires this
>> patch [2] in
> 
> That's not exactly true. I guess calling gitcompile in the hdspmixer sub
> directory (in contrast to the toplevel directory) would give you a
> working hdspmixer.
> 
> I don't know if Ubuntu provides non-security related updates after a
> release. If not, somebody should simply package a git checkout in a PPA.

this is *exactly* what i was trying to do. however simply copying the `debian' 
folder to a checkout doesn't seem to work because the configure scripts are 
missing. to generate this, i need the mentioned patch.

the easiest way would be to have a 1.0.24.2 bugfix release. i suppose this would 
actually make it into the ubuntu release.

tim

-- 
tim@klingt.org
http://tim.klingt.org

May music never just become another way of making money.
  Keith Tippett
