From: Dave Dillow <dave@thedillows.org>
Subject: Semantics of a single period per buffer?
Date: Sun, 25 Nov 2007 14:58:17 -0500
Message-ID: <1196020698.3609.20.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 3548C245F1
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 20:58:22 +0100 (CET)
Received: from obelisk.thedillows.org (obelisk.thedillows.org [192.168.0.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id lAPJwISs016018
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 14:58:18 -0500
Received: from obelisk.thedillows.org (localhost.localdomain [127.0.0.1])
	by obelisk.thedillows.org (8.14.1/8.13.8) with ESMTP id lAPJwIWd003222
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 14:58:18 -0500
Received: (from il1@localhost)
	by obelisk.thedillows.org (8.14.1/8.14.1/Submit) id lAPJwILq003219
	for alsa-devel@alsa-project.org; Sun, 25 Nov 2007 14:58:18 -0500
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

While refining the sis7019 for submission, I found a possible issue with
having a single period per buffer. The easy way out is to set the
minimum number of periods to 2, but I see other drivers allow a single
period. This leads to a question about the semantics of a single period
that I've not been able to resolve using Google.

Any one have any thoughts or pointers to a discussion on having a single
period per buffer? Should it be a one-shot play, or just let it hit XRUN
every time? Other ideas?

Thanks,
Dave
