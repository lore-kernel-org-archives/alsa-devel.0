From: Jaroslav Kysela <perex@perex.cz>
Subject: More HDA NID / control / proc related changes
Date: Tue, 8 Dec 2009 17:58:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912081753300.14639@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E09D5245C6
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 17:58:48 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	D44D8149B6E
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 17:58:48 +0100 (CET)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	C639D8472E
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 17:58:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

 	continuing the work of extending the HDA codec proc contents, I 
would like to introduce two new patches:

ALSA: hda - add more NID->Control mapping
ALSA: hda - introduce HDA_SUBDEV_AMP_FLAG (ControlAmp in proc)

 	Patches can be obtained here:

http://git.alsa-project.org/?p=alsa-kernel.git;a=shortlog;h=topic/hda-nid

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
