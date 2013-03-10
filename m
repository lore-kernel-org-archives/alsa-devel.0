From: Marc Schultz <marcschultz27@gmail.com>
Subject: Add ALSA driver to Buildroot image or add / load it
	after booting the image
Date: Sun, 10 Mar 2013 21:19:40 +0100
Message-ID: <CAMFO430h8z+gNbkjq0WHAbRQ48iLDtfvknEpnNAjuRKBgwzXSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B593B2651B1
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 21:19:41 +0100 (CET)
Received: by mail-vc0-f174.google.com with SMTP id n11so1714277vch.19
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 13:19:40 -0700 (PDT)
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

Hey ALSA-Devel community,

I'm successfully booting a Buildroot made Linux image on my board.
This board has an Cirrus Logic CS4270 sound chip and now I want to
activate the specific sound card driver for it. Is there a good way to
put the CS4270 driver files into the Linux Kernel folders of Buildroot
to get them compressed into the Linux image or do I have to go one of
the following ways after booting the image on my target hardware?

http://www.alsa-project.org/main/index.php/Matrix:Module-cs4270

http://www.alsa-project.org/main/index.php/Driver_Compilation)

Do you have a good workflow for me to get this thing working?

Best regards,
Marc Schultz
