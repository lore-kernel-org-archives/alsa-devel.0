From: "ing. Davide Rizzo" <davide@elpa.it>
Subject: ARM S3C2410: Trigger start problems
Date: Sun, 11 May 2008 08:48:30 +0200
Message-ID: <482696BE.7080406@elpa.it>
Reply-To: davide@elpa.it
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from joe.mail.tiscali.it (joe.mail.tiscali.it [213.205.33.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A6F42444C
	for <alsa-devel@alsa-project.org>;
	Sun, 11 May 2008 08:48:26 +0200 (CEST)
Received: from [127.0.0.1] (217.133.78.74) by joe.mail.tiscali.it (8.0.016)
	id 4816EB0C00E3CC59 for alsa-devel@alsa-project.org;
	Sun, 11 May 2008 08:48:25 +0200
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

I experienced a curious problem.
My platform is a S3C2410 with a PCM3006 codec connected through I2S.
The soc trigger function calls 3 other triggers functions:
- first the codec function
- then the platform function (that starts dma)
- last the the i2s trigger function (that starts i2s peripheral).
The dma start function programs and starts the dma peripheral, but the 
transfer doesn't start because the i2s peripheral isn't started yet.
The s3c2410 specific dma start programs the 1st transfer, but before 
programming the 2nd start it waits about 30ms (2^18 count) in a closed 
loop for 1st transfer to start. After that delay anyway it fails to 
program the 2nd transfer.
After that, when the i2s trigger function is called the 1st samples' 
group starts, but nobody preprograms the 2nd sample group in the dma 
peripheral. When the 1st group ends the dma interrupt service routine is 
called , but it's too late and the 1st samples' group is repeated twice.
I tested 2 solutions:
- In the soc trigger function, call the i2s trigger function BEFORE the 
platform trigger function. I don't know if this solution could broke 
other platforms, but it's the more correct way to solve the problem.
-  (platform specific): In arch/arm/plat-s3c24xx-dma.c, at the end of 
s3c2410_dma_getposition() function, insert a call to 
s3c2410_dma_started(). That function is periodically called by alsa-lib 
when playing, and permits dma to program the 2nd buffer before (but it's 
not guaranteed) the 1st group is completed. With this solution, the 
programming of DMA till waits for the closed loop. I think this is a 
patch, but not the correct solution.
I wonder if other architectures that use DMA suffer the same problem, so 
that the 1st proposed solution could help them, too.
Davide
