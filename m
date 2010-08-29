From: Martin <mwolf@adiumentum.com>
Subject: problem with bisecting a bug in the alsa driver
Date: Sun, 29 Aug 2010 17:57:41 +0200
Message-ID: <4C7A8375.3000009@adiumentum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adiumentum.com (adiumentum.com [83.142.83.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FABA243D8
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 17:57:42 +0200 (CEST)
Received: from [192.168.2.26] (p54A87988.dip.t-dialin.net [84.168.121.136])
	by adiumentum.com (Postfix) with ESMTPSA id C1BBE4400A0
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 17:57:41 +0200 (CEST)
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

hello,

im sorry to post in here but i really dont know how to proceed
with finding the bug i have.

i have an ALC889A codec and since alsa-driver 1.0.22 my
microphone is crackling like hell with every recording.

it works flawlessly on windows and till 1.0.21 of alsa driver.

so i downloaded alsa-driver.git and alsa-kmirror.git
and started gitcompile.

the error is also present in the most recent git.

my next steps were trying to use bisect bad v1.0.22 and bisect good v1.0.21
but im unable to compile the driver with any bisection setting.
maybe i run into problems because i have 2 single git repos?

i really would appreciate a howto for my problem.
i also filed a bug in the bugtracker with more infos included.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5115
