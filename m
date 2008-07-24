From: dinesh <dinesh.dua@coraltele.com>
Subject: [Fwd:  Filling "Struct snd_dma_buffer" manually]
Date: Thu, 24 Jul 2008 19:39:21 +0530
Message-ID: <1216908561.2846.35.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	by alsa0.perex.cz (Postfix) with ESMTP id DD7F72498B
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 16:11:50 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.coraltele.com (Postfix) with ESMTP id BD8201B26EE
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2008 19:41:47 +0530 (IST)
Received: from mail.coraltele.com ([127.0.0.1])
	by localhost (mail.coraltele.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfWJHfqA0ywP for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 19:41:45 +0530 (IST)
Received: from [192.168.4.53] (unknown [192.168.4.53])
	by mail.coraltele.com (Postfix) with ESMTPA id 1B2B51B26A9
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2008 19:41:45 +0530 (IST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



-------- Forwarded Message --------
From: dinesh <dinesh.dua@coraltele.com>
To: alsa-devel <alsa-devel@alsa-project.org>
Subject: [alsa-devel] Filling "Struct snd_dma_buffer" manually
Date: Thu, 24 Jul 2008 18:29:59 +0530


Hello,

I am stuck with a problem please help me.

I have allocated a buffer in ram and i want that if i playback something
from user end then alsa library exchanges data with this buffer using
memory  mapping but for this i have to fill a

 structure  "snd_dma_buffer" in driver code but as i have told i dont
want to use dma so i have to fill it manually with address of ram
buffer.

Please tell me if it is possible if yes then help me.

Thanks in advance..

Regards,
Dinesh Dua

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
