From: Tim Blechmann <tim@klingt.org>
Subject: Re: hdspmixer broken for 96khz
Date: Mon, 04 Apr 2011 09:21:24 +0200
Message-ID: <inbrhl$icc$1@dough.gmane.org>
References: <in74oi$qce$1@dough.gmane.org>
	<20110403081606.GG28811@ltw.loris.tv>
	<201104031139.41395.tim@klingt.org>
	<20110403102516.GJ28811@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 192B02445B
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 09:21:44 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Q6e6U-0001Ou-RJ
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 09:21:38 +0200
Received: from 85-127-91-29.dynamic.xdsl-line.inode.at ([85.127.91.29])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 04 Apr 2011 09:21:38 +0200
Received: from tim by 85-127-91-29.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 04 Apr 2011 09:21:38 +0200
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

> I wonder what went wrong. If you like, feel free to further dig into
> this.
> 
> However, the current on-disk format is utterly stupid, it has no
> meta-information at all, it will break if the order of cards change.
> 
> The whole hdspmixer is a dead-end, even supporting more than one card in
> a single app complicates things like hell (I have an upcoming patch
> series. Took me 6hrs or so just to get switching back/forth between two
> cards right).

the hdspmixer is not perfect, but it more or less worked for years and it is 
used in `production' environments. so breaking the parts that are currently 
working is quite annoying for users.

> So the next thing I'd like to implement is to limit hdspmixer to a
> single card and then run a new instance on the second, third, 4th a.s.o.
> card. Like alsamixer -c 1: hdspmixer -c 1, maybe -c reflecting the ALSA
> card number as found in /proc/asound/cards.
> 
> Anyway, the whole codebase is subtle broken, and the best approach would
> be a rewrite from scratch. Maybe it makes sense to merge hdsp and hdspm,
> first. Comments welcome. ;)

rewriting the hdspmixer doesn't sound like a bad idea to me. reworking the 
sampling rate switching would be a great help as well: the hdsp is the only 
device i know, which requires an external program to switch the sampling rate. a 
few years ago i had a brief look at the driver, but this seemed to be a non-
trivial problem.

cheers, tim

-- 
tim@klingt.org
http://tim.klingt.org

Most of the trouble in this world has been caused by folks who can't
mind their own business, because they have no business of their own to
mind, any more than a smallpox virus has.
  William S. Burroughs
