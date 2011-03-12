From: Ondrej Zary <linux@rainbow-software.org>
Subject: radio-maestro broken (conflicts with snd-es1968)
Date: Sat, 12 Mar 2011 19:19:00 +0100
Message-ID: <201103121919.05657.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 473E82455A
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 19:19:30 +0100 (CET)
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
To: linux-media@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, jirislaby@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,
the radio-maestro driver is badly broken. It's intended to drive the radio on 
MediaForte ESS Maestro-based sound cards with integrated radio (like 
SF64-PCE2-04). But it conflicts with snd_es1968, ALSA driver for the sound 
chip itself.

If one driver is loaded, the other one does not work - because a driver is 
already registered for the PCI device (there is only one). This was probably 
broken by conversion of PCI probing in 2006: 
ttp://lkml.org/lkml/2005/12/31/93

How to fix it properly? Include radio functionality in snd-es1968 and delete 
radio-maestro?

-- 
Ondrej Zary
