From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audio Driver Works In Ubuntu but Crash in
	Debian	After 2nd Run
Date: Wed, 17 Jun 2015 10:01:04 +0200
Message-ID: <55812940.5050906@ladisch.de>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>	<557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CBD79265ACF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 10:02:05 +0200 (CEST)
In-Reply-To: <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Azizul Hakim wrote:
> Driver didn't start the DMA: Not sure how to track on this point. Any suggestion?
> Interrupt do not arrive correctly: Is this the hardware issue or ALSA issue?

These would imply that some your driver, or some code used by your driver,
did not configure the DMA/interrupt correctly.


Regards,
Clemens
