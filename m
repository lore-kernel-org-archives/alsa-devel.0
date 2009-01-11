From: Peter Stokes <linux@dadeos.co.uk>
Subject: [PATCH] Bug in aplay/arecord --list-pcms
Date: Sun, 11 Jan 2009 15:05:21 +0000
Message-ID: <200901111505.21730.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.freeserve.com (unknown [193.252.22.190])
	by alsa0.perex.cz (Postfix) with ESMTP id F23BC2435A
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 16:05:33 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3628.me.freeserve.com (SMTP Server) with ESMTP id 5D09D7000083
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 16:05:33 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (unknown [91.109.204.173])
	by mwinf3628.me.freeserve.com (SMTP Server) with ESMTP id 37A097000081
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 16:05:33 +0100 (CET)
Received: from tuscan.dadeos.co.uk (tuscan.dadeos.co.uk [10.0.1.252])
	by RedDwarf.dadeos.co.uk (8.14.3/8.14.2) with ESMTP id n0BF5LtW005354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 15:05:22 GMT
Content-Disposition: inline
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

I have just discovered a minor logic inversion bug in aplay/arecord --list-pcms functionality.

Basically, executing "aplay --list-pcms" lists all devices capable of capture and executing "arecord --list-pcms" 
lists all devices capable of playback.

Please find below a patch to resolve this issue.

Best regards

Peter Stokes

-------------------------------------------------------------------------------

Signed-off-by: Peter Stokes <linux@dadeos.co.uk>

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 2e14d2a..837e46a 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -287,7 +287,7 @@ static void pcm_list(void)
                name = snd_device_name_get_hint(*n, "NAME");
                descr = snd_device_name_get_hint(*n, "DESC");
                io = snd_device_name_get_hint(*n, "IOID");
-               if (io != NULL && strcmp(io, filter) == 0)
+               if (io != NULL && strcmp(io, filter) != 0)
                        goto __end;
                printf("%s\n", name);
                if ((descr1 = descr) != NULL) {
