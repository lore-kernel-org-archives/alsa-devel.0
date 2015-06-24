From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 24 Jun 2015 21:33:14 +0530
Message-ID: <20150624160314.GM19530@localhost>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 807CE265A2A
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 18:01:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <558ABDB6.4010702@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tyler Yeomans <tyeo098@gmail.com>
Cc: alsa-devel@alsa-project.org, jarkko.nikula@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2015 at 10:24:54AM -0400, Tyler Yeomans wrote:
> Vinod,
> 
> Thank you for looking into this.
> I have attached the dmesg for this device.
> Please note I have tried kernels 3.16/19 4.0 and 4.1, all with same result.
> The attached dmesg file is from booting kernel 4.1/amd64:
> Linux mykro 4.1.0-040100-generic #201506220235 SMP Mon Jun 22
> 06:36:19 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
> On Ubuntu 15.04
I can see these errors:
[    6.012196] (NULL device *): ipc: error DSP boot timeout
[    6.012386] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not
registered

Jarrko, can you see why DSP boot fails, perhpas some resources are
missing/wrong

-- 
~Vinod
