From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: read function
Date: Fri, 11 Jul 2008 11:57:33 -0300
Message-ID: <487774DD.70502@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 511591037FE
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 16:57:41 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 3A49B120022
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 11:57:39 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 3DDD4120024
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 11:57:32 -0300 (BRST)
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

    I am trying to understand how aloop interacts with alsa. I 
understand that the interface between alsa and a driver is an audio 
buffer and pointers, offsets inside this buffer. However, I can't 
discover where these pointers are being used. In pcm_lib.c I inserted 
some debug messages in read/write functions, but they are never called. 
My question is: how is that the snd_pcm_readi, for example, from 
libasound reaches the driver.

Thanks.
