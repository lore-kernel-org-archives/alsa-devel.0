From: Masanari Iida <standby24x7@gmail.com>
Subject: Re: bytcr_rt5640.c:(.text+0x1593b4): undefined reference to `sst_acpi_find_name_from_hid'
Date: Tue, 3 May 2016 04:11:07 +0900
Message-ID: <CALLJCT2-XRx20BUjy6WZkdWK4AmXfX0RMD9sJ5hL0fvZmYxa_g@mail.gmail.com>
References: <20160329142112.GE3705@pd.tnic>
	<56FAAF7F.4050209@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FAAF7F.4050209@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

As of v4.6-rc6,  I hit this error during randconfig.

  LD      init/built-in.o
sound/built-in.o: In function `snd_byt_rt5640_mc_probe':
/home/iida/Repo/linux-2.6/sound/soc/intel/boards/bytcr_rt5640.c:361:
undefined reference to `sst_acpi_find_name_from_hid'
make: *** [vmlinux] Error 1

Masanari

On Wed, Mar 30, 2016 at 1:38 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 03/29/16 07:21, Borislav Petkov wrote:
>> Hi guys,
>>
>> I'm seeing a bunch of those errors today on randconfig builds:
>>
>> sound/built-in.o: In function `snd_byt_rt5640_mc_probe':
>> bytcr_rt5640.c:(.text+0x1593b4): undefined reference to `sst_acpi_find_name_from_hid'
>> make: *** [vmlinux] Error 1
>>
>> ERROR: "sst_acpi_find_name_from_hid" [sound/soc/intel/boards/snd-soc-sst-bytcr-rt5640.ko] undefined!
>> make[1]: *** [__modpost] Error 1
>> make: *** [modules] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> Some of the failing configs attached.
>>
>
> I have 2 patches for this. I'll send them right away.
>
>
> --
> ~Randy
