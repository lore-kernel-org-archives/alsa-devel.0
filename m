From: "Christian Esken (KDE)" <esken@kde.org>
Subject: amixer shows capability "penum" on every Simple mixer
	control
Date: Mon, 12 Mar 2012 22:09:35 +0100
Message-ID: <2e03711055eba5b923f1983b3e7d6f1a@barbarenland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barbarenland.de (dslb-084-062-087-199.pools.arcor-ip.net
	[84.62.87.199]) by alsa0.perex.cz (Postfix) with ESMTP id 6BFE4243F8
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 22:08:17 +0100 (CET)
Received: from 192.168.2.12 (localhost [127.0.0.1])
	by barbarenland.de (Postfix) with ESMTP id 1DC9F84EE7
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 22:09:35 +0100 (CET)
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

 Hello,

 when I run amixer it shows the capability "penum" on nearly every 
 Simple mixer control.
 I posted the bug report 
 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5496 , but 
 Raymond asked me to report it on this mailing list ("as it is related to 
 this patch 6d511eefa05878abee9f8b9145697230de605200 Implements support 
 for capture/playback enums.").

 I posted  details for the following two examples in 
 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5496 :

 1) "Creative X-Fi" does not have any Enum's. alsamixer does not show 
 Enums's. amixer lists "penum" for ALL Simple mixer controls.

 2) "HDA ATI SB" has no penum's, only 3 cenum's. alsamixer shows it 
 correctly, but amixer disagrees and shows penum for NEARLY ALL Simple 
 mixer controls (except for those with cpability "cenum").


 I found this as I received several bug reports for KMix with "absurd" 
 amixer output. I could perceive from those bug report that the bug is 
 affecting a lot (or all?) sound cards.

   Christian
