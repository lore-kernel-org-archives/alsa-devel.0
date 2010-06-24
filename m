From: Adam Rosenberg <adam@alcorn.com>
Subject: Writing a driver for the Blackfin BF537 with two
	CS42448 on SPORT1
Date: Thu, 24 Jun 2010 18:45:29 -0400
Message-ID: <AANLkTiltXihP_J8yRf2ToP52epq_1ruIGiifbjQrNTAj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6449B2417E
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 00:45:31 +0200 (CEST)
Received: by vws20 with SMTP id 20so2968350vws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 15:45:29 -0700 (PDT)
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

I am writing my first ALSA driver for uClinux on Blackfin BF537.  I have a
custom board with two Cirrus Logic CS42448 chips connected to the primary
and secondary data lines of SPORT1.  I was basing my driver off of the
driver for the Analog Devices AD1836 but it does not look like that driver
was written using the latest practices.  I already have the code modified
well enough to communicate with both chips and produce some noise, but it is
obvious that I am not filling the DMA buffer properly.

Please let me know where I can find a driver that would be a better example
for me to reference.  When I have completed the driver I will also need help
on where to submit it so that it will be supported by ALSA for others.

Thank you for your help,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
