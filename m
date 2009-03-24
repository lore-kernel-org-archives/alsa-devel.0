From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 0/7] snd-atmel-ac97c: misc fixes and error
	reporting
Date: Tue, 24 Mar 2009 13:47:43 +0100
Message-ID: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 30AB3103831
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:53 +0100 (CET)
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
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch series contains six minor fixes and one enhancment of the
snd-atmel-ac97c driver. It is based on the for-next branch in sound-2.6 git
repo.

The enhancment is enabling interrupts for error reporting, this might be useful
if you have sound troubles (glitches) on a stressed system.

-- 
Best regards,
Hans-Christian Egtvedt
