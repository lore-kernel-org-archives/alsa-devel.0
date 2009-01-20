From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Could we get the card name in
	/sys/clas/sound/card0/name?
Date: Tue, 20 Jan 2009 03:41:23 +0100
Message-ID: <20090120024123.GA30218@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A15424355
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 03:41:25 +0100 (CET)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

Hmm, it would be nifty if we could get the alsa card name (i.e. the
one shown in [] in /proc/pcm/cards) as an attribute file in
/sys/class/sound/cardX/name. Even more useful would be if this
property would be writable so that the cards may be renamed during
runtime.

This could be very useful to establish stable card names via udev
rules, similar to what is already done to network interface names
("eth0", ...).

Would such a change be acceptable?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
