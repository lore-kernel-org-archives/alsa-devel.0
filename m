From: Hugo Villeneuve <hugo@hugovil.com>
Subject: PCM3008 ALSA Soc driver and Lyrtech SFFSDR board audio
	support (v2)
Date: Wed, 19 Nov 2008 01:37:30 -0500
Message-ID: <1227076652-23370-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DEE42457C
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 07:37:33 +0100 (CET)
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
Cc: davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Reworked and splitted patch based on Mark Brown comments.

Mark, thank-you for your comments. I implemented almost all of
your suggestions, except for the de-emphasis control because I
don't really know how I can export (and test) that interface.
Like you said, maybe we or someone else can do it later.

Hugo Villeneuve
