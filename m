From: Jaroslav Kysela <perex@perex.cz>
Subject: HG vs GIT
Date: Thu, 7 Feb 2008 10:37:29 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 27BF624577
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 10:37:30 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	1ADCF149DF3
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 10:37:30 +0100 (CET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	089714E4B
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 10:37:30 +0100 (CET)
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

Hi,

	it seems that GIT matured somewhat. git-push has been implemneted. 
It was main reason to not use GIT when we made decision between HG and 
GIT.
	As we could have potential problems with branches in HG 
repository, I would like to consider a switch to GIT althought it means 
some changes in my scripts on ALSA server and my ksync tool.
	I just successfully tried (a bit modified hg-to-git.py script) and 
it seems to be working properly.
	Any objections?

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
