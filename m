From: Florian Faber <faber@faberman.de>
Subject: alsamixer crashes with SIGFPE
Date: Thu, 18 Feb 2010 09:29:44 +0100
Message-ID: <4B7CFA78.6090104@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A91D1038BD
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 09:29:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

there are several spots in alsamixer's mixer_display.c that cause SIGFPE
through division by zero if (max-min) is zero:

bar_height = ((volumes[c] - min) * volume_height + max - min - 1) / (max
- min);

value = ((volumes[0] - min) * 100 + (max - min) / 2) / (max - min);

etc.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
