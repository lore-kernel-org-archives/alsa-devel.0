From: Jack Mitchell <ml@embed.me.uk>
Subject: standalone dmic with omap-dmic
Date: Thu, 04 Jun 2015 16:01:22 +0100
Message-ID: <55706842.8020804@embed.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from owm.eumx.net (eumx.net [91.82.101.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3603A26061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 17:34:30 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

I have been trying to get a dmic connected directly into an omap44xx 
working standalone (no twl6040), so far, unsucessfully. Does anyone know 
if this is even possible?

I have tried with a simple-audio-card setup using the dmic-codec and 
omap-dmic as the dai. I have also tried hacking out the twl6040 parts of 
the twl6040 driver to get a dmic only driver. With both of these methods 
I managed to get the drivers loaded but could get nothing recorded with 
an Input/Output error, and then on retry a kernel lockup with regards to 
enabling/disablig the dmic.

Doe anyone have any suggestions; or maybe an idea if this is even 
possible without large changes? Does the dmic driver with twl6040 even 
work anymore; I expect it doesn't get a lot of testing...

Cheers,
Jack.
