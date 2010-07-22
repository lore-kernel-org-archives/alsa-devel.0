From: longer <longer.zhou@gmail.com>
Subject: problems about converting sample rates when using
	ALSA-LIB
Date: Thu, 22 Jul 2010 08:16:21 +0000 (UTC)
Message-ID: <loom.20100722T100951-898@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF4510395E
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 10:25:04 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Obr5T-0001i0-LF
	for alsa-devel@alsa-project.org; Thu, 22 Jul 2010 10:25:04 +0200
Received: from 61.183.225.66 ([61.183.225.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 10:25:03 +0200
Received: from longer.zhou by 61.183.225.66 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 10:25:03 +0200
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

Hi all,

   I have a problem when using ALSA lib . The problem is :

     My ALSA driver only support a special sample rate , so ALSA lib must   
    convert sample rates. But My driver don't get any audio data. When           
    tracing  the code of ALSA lib (alsa-lib-1.0.23), I found that : It mmap 
    a address from my driver , but writing audio data to another address 
    instead of that mmaped address.

   I think this is why my driver don't get any audio data . But I don't know 
 why it don't write audio data to that mmaped address. 

 Can you help me ?  Any advices  would help me a lot.

 Thank you,
 longer.zhou
