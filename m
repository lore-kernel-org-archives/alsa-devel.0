From: Chris Rankin <rankincj@yahoo.com>
Subject: Problem with compiler-matching
Date: Sun, 1 Jun 2003 15:37:53 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306011437.h51EbsGY002645@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta05-svc.ntlworld.com (mta05-svc.ntlworld.com [62.253.162.45])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA23151
	for <alsa-devel@alsa-project.org>; Sun, 1 Jun 2003 16:50:22 +0200
Received: from wittsend.radionet ([80.0.68.28]) by mta05-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20030601143757.LXSD311.mta05-svc.ntlworld.com@wittsend.radionet>
          for <alsa-devel@alsa-project.org>; Sun, 1 Jun 2003 15:37:57 +0100
Received: from wittsend.radionet (localhost [127.0.0.1])
	by wittsend.radionet (8.12.9/8.12.9) with ESMTP id h51EbtDi002646
	for <alsa-devel@alsa-project.org>; Sun, 1 Jun 2003 15:37:56 +0100
Received: (from chris@localhost)
	by wittsend.radionet (8.12.9/8.12.1/Submit) id h51EbsGY002645
	for alsa-devel@alsa-project.org; Sun, 1 Jun 2003 15:37:54 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I understand why you are insisting that people compile the ALSA modules with the same compiler that they used
to compile the kernel. However, I think that there are still some issues to work out:

checking for GCC version... Kernel compiler: gcc 2.96 20000731 (Red Hat Linux 7.3 2.96-112) Used compiler: 2.96
Fatal error: Compiler type does not match
Decoded kernel compiler: type=gcc version=2.96
Decoded used compiler: type=2.96 version=2.96

Cheers,
Chris


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
