From: Chris Rankin <cj.rankin@ntlworld.com>
Subject: [PATCH] ISA DMA compiler warning fix
Date: Sat, 16 Feb 2002 15:48:01 +0000 (GMT)
Message-ID: <200202161548.g1GFm135014565@twopit.underworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from mta06-svc.ntlworld.com (mta06-svc.ntlworld.com [62.253.162.46])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA26845
	for <alsa-devel@alsa-project.org>; Sat, 16 Feb 2002 16:48:16 +0100
Received: from wittsend.underworld ([80.0.71.165])
          by mta06-svc.ntlworld.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020216154803.GLZE7000.mta06-svc.ntlworld.com@wittsend.underworld>
          for <alsa-devel@alsa-project.org>;
          Sat, 16 Feb 2002 15:48:03 +0000
Received: from twopit.underworld (root@twopit [192.168.0.2])
	by wittsend.underworld (8.12.1/8.12.1) with ESMTP id g1GFm2M1027977
	for <alsa-devel@alsa-project.org>; Sat, 16 Feb 2002 15:48:03 GMT
Received: from twopit.underworld (chris@localhost [127.0.0.1])
	by twopit.underworld (8.12.2/8.12.2) with ESMTP id g1GFm1b1014566
	for <alsa-devel@alsa-project.org>; Sat, 16 Feb 2002 15:48:01 GMT
Received: (from chris@localhost)
	by twopit.underworld (8.12.2/8.12.1/Submit) id g1GFm135014565
	for alsa-devel@alsa-project.org; Sat, 16 Feb 2002 15:48:01 GMT
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- pcm_memory.c.orig	Sat Feb 16 14:30:29 2002
+++ pcm_memory.c	Sat Feb 16 15:43:13 2002
@@ -67,7 +67,7 @@
 	*addrp = isa_virt_to_bus(dma_area);
 	return dma_area;
 }
-static inline void *snd_malloc_isa_pages_fallback(size_t size, dma_addr_t *addrp, size_t *sizep, unsigned int flags)
+static inline void *snd_malloc_isa_pages_fallback(size_t size, dma_addr_t *addrp, unsigned long *sizep, unsigned int flags)
 {
 	void *dma_area = snd_malloc_pages_fallback(size, flags, sizep);
 	*addrp = isa_virt_to_bus(dma_area);


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
