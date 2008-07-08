From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] Add support for Mitac Mio A701 smartphone
Date: Tue, 08 Jul 2008 22:39:21 +0200
Message-ID: <87vdzgp0ue.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F9E024478
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 22:39:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, liam.girdwood@wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch serie aims at integration of the Mitac Mio A701 smartphone's sound
system into alsa sound system.

It should be noted that this serie applies upon asoc-v2-dev tree, commit id
e02f9491e1e6d9720e0caffdb8e5edc259f41946, and should not hit alsa tree before
2.6.27, because A701 official support will be included at that version through
arm tree (perhaps even 2.6.28, depending on Russell's time).

Happy review.

--
Robert
