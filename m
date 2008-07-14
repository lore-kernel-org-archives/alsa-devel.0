From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
 for matching bus and codec drivers
Date: Mon, 14 Jul 2008 11:14:41 -0500
Message-ID: <487B7B71.9060606@freescale.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>	<20080714134930.GC25448@sirena.org.uk>	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AF39243D0
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 18:14:47 +0200 (CEST)
In-Reply-To: <20080714150527.GD25448@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

>> The PowerPC side isn't without fault too. PowerPC still doesn't have a
>> good way to load the fabric/machine driver.
> 
> I'm finding it difficult to square these two statements - from an ASoC
> point of view the main thing this patch is doing is adding a machine
> driver and that's not something that's going to go away.  

Jon's concern is that there is no straightforward way to build a kernel with
multiple fabric drivers and have the right one chosen via the device tree.  This
is just a limitation of the device tree model, and no one has come up with a
good solution yet.

The problem still exists in ASoC V2.  However, it's not anything that ASoC
itself needs to be concerned with.  It's purely a PowerPC problem.

>> Which are we going to call it, fabric or machine? I had been working
>> on the Apple code in sound/aoa. It is called fabric in that code. The
>> equivalent driver is called machine in ASoC v1.
> 
> ASoC has always called it a machine driver.

Wait, I thought it's supposed to be called a fabric driver now?  On PowerPC, it
should be called a fabric driver because we already have machine drivers.

-- 
Timur Tabi
Linux kernel developer at Freescale
