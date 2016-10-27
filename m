From: holger@dehnhardt.org
Subject: MOTU Midi Express XT
Date: Thu, 27 Oct 2016 06:16:50 +0000
Message-ID: <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from punkt-k.de (punkt-k.de [84.200.50.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F135261560
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 08:17:08 +0200 (CEST)
Received: from [84.200.50.24] (port=45340 helo=owncloud.dehnhardt.org)
 by punkt-k.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <holger@dehnhardt.org>)
 id 1bzdze-0001SJ-D2
 for alsa-devel@alsa-project.org; Thu, 27 Oct 2016 08:16:51 +0200
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

I own a MOTU Midi Express XT 8x8 interface which is connected through the parallel port. Recently
I upgraded my system and the new motherboard does not have an ISA parallel port anymore...
So I bought a PCI parallel port extension card - hoping that it will work with the ALSA driver
(mtpav).
So I changed the interrupt an port address in modules.conf but the driver is no longer recognized
as an ALSA driver even though it loads without errors.
As the device still perfectly fits my needs I would like to modify the driver to get it working
again. 
Can anyone give me advice what should be changed in the drivers code to make it work on a pci port?

Thanks

Holger
