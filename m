From: Chris Rankin <cj.rankin@ntlworld.com>
Subject: CVS ALSA and sequencer - config problem>
Date: Thu, 23 May 2002 23:51:21 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205232251.g4NMpLYj021133@twopit.underworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta05-svc.ntlworld.com (mta05-svc.ntlworld.com [62.253.162.45])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA21553
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 01:06:47 +0200
Received: from wellhouse.underworld ([80.0.71.202])
          by mta05-svc.ntlworld.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020523225122.CKC2755.mta05-svc.ntlworld.com@wellhouse.underworld>
          for <alsa-devel@alsa-project.org>;
          Thu, 23 May 2002 23:51:22 +0100
Received: from twopit.underworld (root@twopit [192.168.0.2])
	by wellhouse.underworld (8.12.3/8.12.3) with ESMTP id g4NMpMVh008807
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2002 23:51:22 +0100
Received: from twopit.underworld (chris@localhost [127.0.0.1])
	by twopit.underworld (8.12.3/8.12.3) with ESMTP id g4NMpL3i021134
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2002 23:51:21 +0100
Received: (from chris@localhost)
	by twopit.underworld (8.12.3/8.12.1/Submit) id g4NMpLYj021133
	for alsa-devel@alsa-project.org; Thu, 23 May 2002 23:51:21 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am having trouble compiling the OSS-emulation modules for the CVS
ALSA sequencer. Part of the trouble seems to be that the Makefiles
expect CONFIG_SND_SEQUENCER_OSS to be 'y' instead of 'm'; specifically
in

alsa-kernel/core/seq/oss/Makefile
alsa-kernel/synth/emux/Makefile

However, I can't get make to enter the directory where snd-oss-seq.o
lives at all. Does anyone have any ideas, please?

Cheers,
Chris

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
