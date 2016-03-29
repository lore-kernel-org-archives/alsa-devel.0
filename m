From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: bytcr_rt5640.c:(.text+0x1593b4): undefined reference to
 `sst_acpi_find_name_from_hid'
Date: Tue, 29 Mar 2016 09:38:23 -0700
Message-ID: <56FAAF7F.4050209@infradead.org>
References: <20160329142112.GE3705@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329142112.GE3705@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/29/16 07:21, Borislav Petkov wrote:
> Hi guys,
> 
> I'm seeing a bunch of those errors today on randconfig builds:
> 
> sound/built-in.o: In function `snd_byt_rt5640_mc_probe':
> bytcr_rt5640.c:(.text+0x1593b4): undefined reference to `sst_acpi_find_name_from_hid'
> make: *** [vmlinux] Error 1
> 
> ERROR: "sst_acpi_find_name_from_hid" [sound/soc/intel/boards/snd-soc-sst-bytcr-rt5640.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Some of the failing configs attached.
> 

I have 2 patches for this. I'll send them right away.


-- 
~Randy
