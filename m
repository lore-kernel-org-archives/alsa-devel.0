From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
 After 2nd Run
Date: Wed, 17 Jun 2015 10:05:34 +0100
Message-ID: <1434531934.2471.9.camel@loki>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
 <55812940.5050906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C63265B90
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 11:05:52 +0200 (CEST)
In-Reply-To: <55812940.5050906@ladisch.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

+ Peter for Beaglebone

On Wed, 2015-06-17 at 10:01 +0200, Clemens Ladisch wrote:
> Azizul Hakim wrote:
> > Driver didn't start the DMA: Not sure how to track on this point. Any suggestion?
> > Interrupt do not arrive correctly: Is this the hardware issue or ALSA issue?
> 
> These would imply that some your driver, or some code used by your driver,
> did not configure the DMA/interrupt correctly.

On beaglebone it may also be that the McBSP port clocking is not
configured correctly.

Liam
