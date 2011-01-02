From: M0Rf30 <morf3089@gmail.com>
Subject: Acer Aspire 4930G mixer regression
Date: Sun, 02 Jan 2011 11:54:51 +0100
Message-ID: <4D20597B.8050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 51AB2245D7
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 11:55:32 +0100 (CET)
Received: by wyi11 with SMTP id 11so12456574wyi.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Jan 2011 02:55:31 -0800 (PST)
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

The soundcard Realtek ALC888 needs a fix when used with 
acer-aspire-4930g. Main volume is not initialized. Please take a look 
here https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5176.
I wrote a patch to solve this problem on my laptop. And it works like a 
charm.Thanks in advance.
