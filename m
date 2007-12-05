From: Christian Schumann <schumann@physik.uni-kl.de>
Subject: Mindprint DI-MOD USB
Date: Wed, 5 Dec 2007 09:49:35 +0100
Message-ID: <20071205084935.GA24821@diller-5.physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
	by alsa0.perex.cz (Postfix) with ESMTP id F4123103940
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 09:49:39 +0100 (CET)
Received: from cartman.physik.uni-kl.de (cartman.physik.uni-kl.de
	[131.246.236.200])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lB58nSYY019137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 5 Dec 2007 09:49:28 +0100
Received: from diller-5.physik.uni-kl.de (diller-5.physik.uni-kl.de
	[131.246.236.224])
	by cartman.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lB58gOpu032374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 5 Dec 2007 09:42:25 +0100
Received: from diller-5.physik.uni-kl.de (localhost.localdomain [127.0.0.1])
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lB58nZJv024928
	for <alsa-devel@alsa-project.org>; Wed, 5 Dec 2007 09:49:35 +0100
Received: (from schumann@localhost)
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Submit) id lB58nZnI024927
	for alsa-devel@alsa-project.org; Wed, 5 Dec 2007 09:49:35 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

in janoary, I wrote to this list about an extension of the usb-audio
driver for the Mindprint DI-MOD USB, but neither hat the necessary
information at hand, no became a reply. In the meantime I did some
research and here's what I found out:

The DI-MOD USB is pretty usb-audio class compliant with the exception of
the spdif output, which has to be activated manaually. I did this with
the windows driver, but it would be nice to be able to do that with
ALSA. 
I have a Envoice MkII with the DI-MOD USB, and my suggestion would be to
automatically enable the spdif output when initializing the driver. The
spdif output does not have any other effect on the card functionality.
This could for example be included into the setup quirks for usb
interfaces.

The info I got from Markus Medau at usb-audio.com is the following:

Digital: Vendorrequest, Typ: Out/Vendorinterface, bReq setCur, wVal 0x00, wIndex 0x04, data length 1: data 0x01
Analog: Vendorrequest, Typ: Out/Vendorinterface, bReq setCur, wVal 0x00, wIndex 0x02, data length 1: data 0x00

I don't have experience in writing drivers, but if someone can give me a
clue where to start, I could give it a try.

Regards
Christian

-- 
------------------------------------------------------------------------
Dipl.-Phys. Christian Schumann   |Technische Universitaet Kaiserslautern
Mail: schumann@physik.uni-kl.de  |           Fachbereich Physik
Tel.: 0631/205-4842 (Office)     |     http://www.physik.uni-kl.de 
Tel.: 0631/205-4843 (Lab)        |
Fax.: 0631/205-3902              |    
Post: Erwin-Schroedinger-Strasse, D-67663 Kaiserslautern
-------------------------------------------------------------------------
