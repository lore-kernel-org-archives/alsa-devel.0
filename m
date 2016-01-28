From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: CherryTrail SST firmware limitations query
Date: Thu, 28 Jan 2016 21:54:16 +0530
Message-ID: <20160128162416.GR11130@localhost>
References: <56A162A1.1070602@emutex.com>
 <56A1657A.5060600@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6694126585A
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 17:20:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56A1657A.5060600@emutex.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan O'Donovan <dan@emutex.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2016 at 11:10:50PM +0000, Dan O'Donovan wrote:
> (Sorry, re-sending as I wasn't subscribed to the alsa-devel mailing
> list on my previous attempt)
> 
> Hi Vinod
> 
> I am currently attempting to use the SSP0 port on an Intel X5-Z8300
> SoC (Cherry Trail) with a new codec.
> 
> I have seen that you have committed SST firmware 'fw_sst_22a8.bin'
> and related SST audio soc drivers in the past, so I hope you don't
> mind if I ask you some questions about it here.
> 
> Primarily, I am wondering if there are any limitations imposed by
> that firmware binary that I need to be aware of. I haven't been able
> to find much information about what this firmware does or doesn't
> support.

That binary is not for CHT. Each Bin is specfic to a platform. I have
the BYT and BSW versions, but not CHT

> 
> For example, existing CHT SST machine drivers suggest that the PCM
> bit clock is fixed at 19.2MHz.

Yes, the MCLK will be 19.2 here

> Also, I am wondering if all SSP ports on the SoC are supported by
> that firmware, or if it is limited to just SSP2?

SSP2, for SSP0 we need to get a new version

> Are there any other limitations that I may need to be aware of in
> the firmware (or in the SSP back-end driver) when attempting to
> connect a new codec (TI PCM5122 initially) to SSP0.

Bigger pole will be getting the firmware. Usually we support I2S and TDM
modes

HTH
-- 
~Vinod
