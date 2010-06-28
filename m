From: Florian Faber <faber@faberman.de>
Subject: Card information in /proc or /sys
Date: Mon, 28 Jun 2010 21:04:26 +0200
Message-ID: <4C28F23A.9050804@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id A7FD9243F6
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 21:04:47 +0200 (CEST)
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

Hi,

I want to expose more information about the sound card's ports (names,
connectors etc.) to userspace in a standardized manner. Does ALSA have
predefined locations for this in /sys, or would /proc
(snd_card_proc_new) still be the way to go?


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
