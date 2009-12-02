From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: About TASCAM US-122 mkII support
Date: Thu, 3 Dec 2009 00:59:24 +0100
Message-ID: <200912030059.25060.fzu@wemgehoertderstaat.de>
References: <4B16A363.50503@mail.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 279D5103819
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 00:59:29 +0100 (CET)
In-Reply-To: <4B16A363.50503@mail.desy.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alberto Martinez de la Ossa <delaossa@mail.desy.de>
Cc: alsa-devel@alsa-project.org, samuel.mimram@ens-lyon.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 02 Dezember 2009 schrieb Alberto Martinez de la Ossa:
> Unfortunately, the new model (US-122 mkII), the one I have, is not 
> supported yet.

hallo alberto,

please post the output of
$ lsusb
while the new device is plugged.

maybe it suffices to just add it's id to the us122l driver.

karsten
