From: Roger Mach <bigmach@us.ibm.com>
Subject: Patch to fix 0000557: SNDCTL_DSP_GETOPTR not working correctly in
 specific situation
Date: Thu, 26 May 2005 08:46:49 -0700
Message-ID: <1117122409.4786.35.camel@w-rmach.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 86CDC1F4
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2005 17:46:53 +0200 (MEST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j4QFkpmD599472
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2005 11:46:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4QFkohT231066
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2005 09:46:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j4QFkoaK021820
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2005 09:46:50 -0600
Received: from IBM-7PY89WP400D.beaverton.ibm.com (IBM-7PY89WP400D.beaverton.ibm.com [9.47.21.174])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j4QFkoRf021750
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2005 09:46:50 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have just posted a patch which fixes this problem.  As was noted in a
previous comment, this is an accessibility issue when used in text-to-
speech applications.

-- Roger



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
