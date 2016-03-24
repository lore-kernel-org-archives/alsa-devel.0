From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>
Subject: simple-audio-card and external dynamic clock
Date: Thu, 24 Mar 2016 22:51:36 +0100
Message-ID: <56F46168.7040201@laposte.net>
Reply-To: emmanuel.fuste@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz26.laposte.net [194.117.213.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB3F260515
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 22:51:30 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout014 (Postfix) with ESMTP id DD6D611F1B9
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 22:51:29 +0100 (CET)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.laposte [10.128.63.5])
 by lpn-prd-vrout014 (Postfix) with ESMTP id D894D11EDA8
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 22:51:29 +0100 (CET)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
 by lpn-prd-vrin004 (Postfix) with ESMTP id C9C2D70E2B9
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 22:51:29 +0100 (CET)
Received: from [10.0.0.20] (161.165.115.78.rev.sfr.net [78.115.165.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lpn-prd-vrin004 (Postfix) with ESMTPSA id A402970E2B8
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 22:51:29 +0100 (CET)
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

Hello,

I m very new to ASoC (and not native english speaker) so be indulgent ;-)
The context  : am335x-boneblack.
I want to drive simple I2S targets. With the ongoing developments, and 
recent patches posted here, this is a very simple job for the 
simple-audio-card machine driver even with fixed external master clock.
I want to go further using a programmable external clock (si570) which 
is not very complicated thanks to the CCF.
But now I want to use the dynamic nature of this external master clock 
(through CCF) to be able to generate 44.1khz AND 48 multiples of fs 
which is not natively possible on the BBB because of integer fs scaling 
only and/or no dedicated audio PLL.
I know that the same could be achieved on the BBB with switching between 
internal clock (24mhz) and external one (24.576mhz) gated by GPIO1_27, 
but this is another story.

Which direction is the right one ?
- dedicated machine driver ?
- or something more generic / reusable implemented in the 
simple-audio-card drivers through helpers routines ?
- or something else ?

Than you.
Emmanuel.
