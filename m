From: Roel Kluin <12o3l@tiscali.nl>
Subject: sound/pci/au88x0/au88x0_core.c: incorrect for loop in
	vortex_mixer_init()
Date: Wed, 05 Mar 2008 23:27:24 +0100
Message-ID: <47CF1E4C.2060204@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 3296110385E
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 23:27:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

in sound/pci/au88x0/au88x0_core.c:430 (linus' tree) it reads in
commented code:

for (x = 0; x > 0x80; x++) {

Not sure whether this is important but it appears to be incorrect.
should it be 'x < 0x80' ?
