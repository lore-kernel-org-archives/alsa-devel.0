From: Jaroslav Kysela <perex@perex.cz>
Subject: Request for compilation test - v1.0.25
Date: Mon, 23 Jan 2012 12:11:26 +0100
Message-ID: <4F1D405E.50301@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id BB9E9244AE
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 12:11:06 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	AD3401498C9
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 12:11:06 +0100 (CET)
Received: from t510.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	A11808503E
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 12:11:05 +0100 (CET)
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

	I would like to ask for a package compilation test in your distribution
for latest ALSA package snapshots available at:

http://www.alsa-project.org/snapshot/

	At this time, these snapshots are available:

alsa-driver 	1.0.24.110.g22743.2525.ge60f5
alsa-lib 	1.0.24.1.53.g98d4e
alsa-utils 	1.0.24.2.26.g7d33a
alsa-firmware 	1.0.24.1.3.g3c38d
alsa-tools 	1.0.24.1.51.g234fa
alsa-oss 	1.0.17.2.g1dfe1
alsa-plugins 	1.0.24.11.gb3fb5
alsa-python 	1.0.24.2.g4c452

	Please, report any compilation/installation issues to this list (you
may add CC to me). I am going to make 1.0.25 release on Wednesday.

	The alsa-driver package will not support the kernels bellow 2.6.18
(released Sep 20 2006), from README:

 - Vanilla 3.0 to 3.2
 - Vanilla 2.6.18 to 2.6.39

	I kept the 2.4 build code, but it is not maintained and definitely, it
will be removed in next alsa-driver versions.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
