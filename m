From: "ing. Davide Rizzo" <davide@elpa.it>
Subject: ARM S3C2410: Trigger stop problems
Date: Sun, 11 May 2008 08:53:07 +0200
Message-ID: <482697D3.1000306@elpa.it>
Reply-To: davide@elpa.it
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from joe.mail.tiscali.it (joe.mail.tiscali.it [213.205.33.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 41D3924423
	for <alsa-devel@alsa-project.org>;
	Sun, 11 May 2008 08:53:02 +0200 (CEST)
Received: from [127.0.0.1] (217.133.78.74) by joe.mail.tiscali.it (8.0.016)
	id 4816EB0C00E3D0E1 for alsa-devel@alsa-project.org;
	Sun, 11 May 2008 08:53:01 +0200
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

My platform is a S3C2410 with a PCM3006 codec connected through I2S.
I have a problem on trigger stop: some part of the sound is replayed at 
the sound end.
I noticed that the s3c2410-pcm enqueue function at the end of the sound 
reprograms the dma at initial values, is this wanted ? Why ?
Who should call the trigger stop function to stop the sound at the exact 
final sample ?
Davide
