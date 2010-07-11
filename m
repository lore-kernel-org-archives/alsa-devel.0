From: arnaud.patard@rtp-net.org
Subject: [patch 0/2] Kirkwood audio fixes
Date: Sun, 11 Jul 2010 23:28:30 +0200
Message-ID: <20100711212830.815827907@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CB5624509
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Jul 2010 23:52:47 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, tbm@cyrius.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org



Hi,

While working on the t5325 audio support, I found two small buglets in the
kirkwood ASoC support. 

The first one is aiming at fixing mono audio playback and should fix mono
playback for all platforms.
The second is adding support for muting/unmuting kirkwood audio. It's 
mainly usefull for the t5325 which has a bootloader playing with this
(hardware default is not muted).


Arnaud
