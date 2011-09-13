From: gmane@colin.guthr.ie
Subject: Allow alsa configuration to be loaded from a
	alsa.conf.d folder v2
Date: Tue, 13 Sep 2011 22:03:59 +0100
Message-ID: <1315947840-27615-1-git-send-email-gmane@colin.guthr.ie>
References: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 347F924372
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 23:04:03 +0200 (CEST)
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id D427810B0CB
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 22:04:02 +0100 (BST)
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id K6LCfjq6BieI for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 22:04:02 +0100 (BST)
In-Reply-To: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
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

2nd version of the patch without the need to use autotools to preprocess
alsa.conf.

This just reuses the "@func datadir" function used to load individual card
files a few lines below. I should have spotted this the first time round really.

Col
