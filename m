From: Jaroslav Kysela <perex@perex.cz>
Subject: HG -> GIT migration
Date: Tue, 20 May 2008 13:21:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 56C4824772
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 13:21:14 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	4CD9E149E2D for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 13:21:14 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	3B06484375 for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 13:21:14 +0200 (CEST)
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

	I finished migration from HG to GIT. All repositories are 
converted and we have one "new" repository - alsa-kernel.git which is full 
Linux 2.6 GIT tree. The old HG alsa-kernel repository was renamed to 
alsa-kmirror - just to track our changes in continuous timeline for 
releases and packaging. HG access to all repositories is closed now.
	More information can be obtained here:

http://www.alsa-project.org/main/index.php/GIT_Server

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
