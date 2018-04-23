From: Johannes Geiss <johannes.geiss@web.de>
Subject: Linux-Kernel: System freezes after hibernate or
 suspend on a Mac mini 6, 2
Date: Mon, 23 Apr 2018 08:53:41 +0200
Message-ID: <20180423085341.6c72de13@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F7EC267284
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 08:53:51 +0200 (CEST)
Received: from localhost.localdomain ([84.145.13.108]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LwqJw-1eLtlG1REm-016OJ9 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018
 08:53:50 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello ALSA-Development,

I bisected a problem in the Linux kernel 4.14. (This may also concern
newer kernel versions.)

Using a Mac mini 6,2 computer the kernel freezes after a resume from
hibernation or suspend.

The bisection resulted, that the patch
1f7f51a63114bab3a05920f4b1343154e95e2cb6 may be the culprit.

Please have a look at the description and comments of the bug
https://bugzilla.kernel.org/show_bug.cgi?id=198233 and tell me if our
assumption is correct or not.

Thank you very much for your cooperation.
Johannes Geiss
-- 

 ------//--------------------------------------------------------------
      //    Johannes R. Geiss                       Mac mini server and
  \\ //                                                OpenPandora user
 --\X/-----------------------------------------------------------------
