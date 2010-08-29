From: Thor Kristoffersen <thorkr@gmail.com>
Subject: X-Fi Titanium: Capture is possible only with unmuted
	input
Date: Sun, 29 Aug 2010 22:36:45 +0200
Message-ID: <m2pqx1yx42.fsf@getmail.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.getmail.no (smtp.getmail.no [84.208.15.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 56A892443F
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 22:36:47 +0200 (CEST)
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
	by get-mta-out03.get.basefarm.net
	(Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20
	2008))
	with ESMTP id <0L7X0039OL993770@get-mta-out03.get.basefarm.net> for
	alsa-devel@alsa-project.org; Sun, 29 Aug 2010 22:36:45 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
	(localhost.localdomain [127.0.0.1])	by localhost (Email Security
	Appliance)
	with SMTP id 88EF91799205_C7AC4DDB	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 20:36:45 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
	with ESMTP id 682141797BB2_C7AC4DDF	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 20:36:45 +0000 (GMT)
Received: from localhost ([84.215.109.218]) by get-mta-in01.get.basefarm.net
	(Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20
	2008))
	with ESMTP id <0L7X00JHWL99KO10@get-mta-in01.get.basefarm.net> for
	alsa-devel@alsa-project.org; Sun, 29 Aug 2010 22:36:45 +0200 (MEST)
Received: from thor by localhost with local (Exim 4.72 #1 (Debian))
	id 1OpocP-0001Sa-9T	for <alsa-devel@alsa-project.org>; Sun,
	29 Aug 2010 22:36:45 +0200
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

Hi,

I'm having issues with an X-Fi Titanium and ALSA.  The problem is that
it appears to be impossible to capture without unmuting the channel I'm
capturing from.  I assume that this must be a bug.  If there's anything
I can do to assist with debugging this, please let me know.

This is my software configuration:
 - Debian Squeeze
 - Linux 2.6.32 (Debian Linux 2.6.32-20)
 - alsa-lib 1.0.23

Best regards,
Thor Kristoffersen
