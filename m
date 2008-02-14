From: rmgls@free.fr
Subject: midi problem
Date: Thu, 14 Feb 2008 12:24:54 +0100
Message-ID: <20080214102507.AF98832280E@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 8131124473
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 11:25:08 +0100 (CET)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id D0E73322829
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 11:25:07 +0100 (CET)
Received: from free.fr (evr27-1-88-172-40-194.fbx.proxad.net [88.172.40.194])
	by smtp7-g19.free.fr (Postfix) with ESMTP id AF98832280E
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 11:25:07 +0100 (CET)
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

upgrading to kernel 2.6.24.1 and alsa-hg-20080213, (libs in sync),
on debian: trying to play some midi files, with aplaymidi to:
 timidity/mpu/rme midi port,
i receive the following message:

rtc: lost some interrupt at 1024hz

perhaps, it's not alsa related but!
Do you think it is related to the config?
the symptom appeared since 2.6.24 kernel.
in case, can you tell me what config options can influence this behaviour,
(i have read and applied the low_latency doc),
and if this is missing in the doc, to avoid such questions, can you
add some words somewhere please?

Thanks in advance for reply.

rmgls@free.fr

rmgls@free.fr
