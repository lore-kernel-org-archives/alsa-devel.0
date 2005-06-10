From: Joachim Deguara <dga@idmt.fraunhofer.de>
Subject: [PATCH] Madi multi madness
Date: Fri, 10 Jun 2005 11:17:51 +0200
Message-ID: <42A95ABF.8050707@idmt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060402070008080208070703"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgw12.fraunhofer.de (mailgw12.fraunhofer.de [153.96.1.61])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 490BF206
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 11:17:54 +0200 (MEST)
Received: from mailgw12.fraunhofer.de (localhost [127.0.0.1])
	by mailgw12.fraunhofer.de (8.13.3+/8.13.3) with ESMTP id j5A9HrkJ011668
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 11:17:53 +0200 (CEST)
Received: from kso.emt.iis.fhg.de (dhcp-192-102-160-2.emt.iis.fhg.de [192.102.160.2])
	by mailgw12.fraunhofer.de (8.13.3+/8.13.3) with ESMTP id j5A9HqA5011648
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 11:17:53 +0200 (CEST)
Received: from emt.iis.fhg.de (ksi.emt.iis.fhg.de [10.128.1.2])
	by kso.emt.iis.fhg.de (8.11.1/8.11.1) with ESMTP id j5A9Hql04602
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 11:17:52 +0200 (MEST)
Received: from idserv01.emt.iis.fhg.de (localhost [127.0.0.1])
	by emt.iis.fhg.de (8.11.1/8.11.1) with ESMTP id j5A9HqP19946
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 11:17:52 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060402070008080208070703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A problem exists with a virtual multi card that has a HDSP Madi card in 
it and uses more than 32 of its channels. I increased the number of 
channels a real card could have for the virtual card from 32 to 64.

-joachim
-- 
Joachim Deguara				Email: dga@idmt.fraunhofer.de
Fraunhofer IDMT, Langewiesener St. 22, 98693 Ilmenau, Germany
Phone: +49 3677/69-4851 		Fax:   +49 3677/69-4399

--------------060402070008080208070703
Content-Type: text/x-patch;
 name="pcm_multi_madi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_multi_madi.patch"

--- pcm_multi.c	2005-05-23 11:03:20.000000000 +0200
+++ pcm_multi.c_madi_fix	2005-06-10 11:14:53.890937000 +0200
@@ -764,7 +764,7 @@
 	snd_pcm_multi_t *multi;
 	unsigned int i;
 	snd_pcm_stream_t stream;
-	char slave_map[32][32] = { { 0 } };
+	char slave_map[64][64] = { { 0 } };
 	int err;
 
 	assert(pcmp);

--------------060402070008080208070703--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
