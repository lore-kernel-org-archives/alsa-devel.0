From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/5] compress: add compress data API to ALSA
 kernel
Date: Fri, 2 Sep 2011 15:23:01 +0100
Message-ID: <20110902142301.GB32736@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<20110902113056.GA27415@opensource.wolfsonmicro.com>
	<000601cc6979$437b11c0$ca713540$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10E32243DA
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 16:23:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <000601cc6979$437b11c0$ca713540$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, 'Vinod Koul' <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 09:04:42AM -0500, Pierre-Louis Bossart wrote:

> Not yet. I wanted to have more visibility into alsa-lib use for 
> Android before doing into changes there.
> Let's talk about it at LPC.

FWIW and the benefit of the list alsa-lib won't fly for adoption by
Google as part of the standard Android system unless it gets relicensed,
though obviously other people are happily using it in production and
there's systems other than Android out there.  tinyalsa is probably the
way forward for Google.
