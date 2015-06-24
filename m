From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 24 Jun 2015 15:41:15 +0530
Message-ID: <20150624101115.GI19530@localhost>
References: <5589D025.7090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E73326054D
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 12:09:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5589D025.7090700@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tyler Yeomans <tyeo098@gmail.com>, liam.r.girdwood@intel.com, jarkko.nikula@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2015 at 05:31:17PM -0400, Tyler Yeomans wrote:
> Hello Vinod,
Pls cc relevant mailing list, in this case alsa. I have cced Liam and Jarrko
as well
> 
> I am writing to you because unfortunately I have exhausted my search
> and I am unable to get ALSA sound working on my Baytrail minipc.
> My dmesg only reports that: byt-rt5640 byt-rt5640: ASoC: CPU DAI
> baytrail-pcm-audio not registered
> aplay -l rightfully says there are no sound cards as the driver is
> not registered.
Can you give more details of your, does this enable HDA audio or I2S audio?

> I have acquired the firmware file from the chromium repo here (https://kernel.googlesource.com/pub/scm/linux/kernel/git/firmware/linux-firmware/+/refs/heads/master/intel/fw_sst_0f28.bin-48kHz_i2s_master)
> as was directed by the OP in this forum post:
> http://ubuntuforums.org/showthread.php?t=2254631
> 
> But unfortunately it seems the driver is still not loading
> correctly, even on Ubuntu 15.04 with ALSA 1.0.28
Do you have dmesg for us to look at so that we can see what might be going
wrong

> I see on gmane you are working on Skylake driver, could your work
> there possibly be backported to the Baytrail/RT5640 chipset?
No they are entirely different hw, so it will not work. We have uostream BYT
driver and they should work

-- 
~Vinod
