From: Christophe Lohr <christophe.lohr@cegetel.net>
Subject: Remarks about  alsa-lib-1.0.29/test/pcm*.c
Date: Sun, 31 May 2015 13:51:26 +0200
Message-ID: <556AF5BE.1070409@cegetel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------070405040709080809070705
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp22.services.sfr.fr (smtp22.services.sfr.fr [93.17.128.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B2F2261536
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2015 13:51:27 +0200 (CEST)
Received: from filter.sfr.fr (localhost [79.94.58.129])
 by msfrf2209.sfr.fr (SMTP Server) with ESMTP id CCF7A7000071
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2015 13:51:26 +0200 (CEST)
Received: from [192.168.1.4] (129.58.94.79.rev.sfr.net [79.94.58.129])
 by msfrf2209.sfr.fr (SMTP Server) with ESMTP id A8E9A70000A5
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2015 13:51:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070405040709080809070705
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I'm looking about examples in alsa-lib-1.0.29/test/

I have two questions about:

pcm.c line 71: In case of a FLOAT format, maxval is 1.0, isn't it?

pcm_min.c lin 79: Variable err does not refers to the previous call?

Did I understood well?

Best regards
Christophe

--------------070405040709080809070705
Content-Type: text/x-patch;
 name="misc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="misc.patch"

diff -uprN alsa-lib-1.0.29.origin/test/pcm.c alsa-lib-1.0.29/test/pcm.c
--- alsa-lib-1.0.29.origin/test/pcm.c	2015-02-26 13:34:52.000000000 +0100
+++ alsa-lib-1.0.29/test/pcm.c	2015-05-31 13:36:42.806463600 +0200
@@ -68,7 +68,7 @@ static void generate_sine(const snd_pcm_
 		} fval;
 		int res, i;
 		if (is_float) {
-			fval.f = sin(phase) * maxval;
+			fval.f = sin(phase);
 			res = fval.i;
 		} else
 			res = sin(phase) * maxval;
diff -uprN alsa-lib-1.0.29.origin/test/pcm_min.c alsa-lib-1.0.29/test/pcm_min.c
--- alsa-lib-1.0.29.origin/test/pcm_min.c	2015-02-26 13:34:52.000000000 +0100
+++ alsa-lib-1.0.29/test/pcm_min.c	2015-05-31 13:38:58.166156767 +0200
@@ -39,7 +39,7 @@ int main(void)
                 if (frames < 0)
                         frames = snd_pcm_recover(handle, frames, 0);
                 if (frames < 0) {
-                        printf("snd_pcm_writei failed: %s\n", snd_strerror(err));
+                        printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
                         break;
                 }
                 if (frames > 0 && frames < (long)sizeof(buffer))

--------------070405040709080809070705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070405040709080809070705--
