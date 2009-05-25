From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: pb with AC'97 codec on atmel at91 boards
Date: Mon, 25 May 2009 17:15:44 +0200
Message-ID: <4A1AB620.5090108@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 73E7B2437D
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:28:51 +0200 (CEST)
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id n4PFOD621169
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:24:14 +0200 (MEST)
Received: from [127.0.0.1] ([10.159.245.197])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id n4PFFog21743
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:15:50 +0200 (MEST)
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

I am currently working on an AC'97 driver for ATMEL boards(AT91), and I 
encounter some problems.
On the board we have an AD1981b, and looking at the file ac97_patch.c I 
was wondering in the function patch_ad1881 why is there 3 codecs?
I've got the AD1981b datasheet, but the registers description is not 
really clear to me(vendor id register).

My problem is: when I try to read this registers(vendor id) during the 
probe(in snd_ac97_mixer), it will fail, and from time to time I will 
even not be able to recognize the codec...

So my question is: is that normal that in the function patch_ad1881 the 
code fails to read these lines:
	codecs[1] = patch_ad1881_unchained(ac97, 1, (1<<14));
	codecs[2] = patch_ad1881_unchained(ac97, 2, (1<<13));


Regards,
Sedji
