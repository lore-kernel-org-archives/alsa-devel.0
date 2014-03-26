From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 26 (sound/soc/codecs/cs42l52.c)
Date: Wed, 26 Mar 2014 13:01:27 -0700
Message-ID: <53333217.7090706@infradead.org>
References: <20140326173539.543d4122020476c3aefc0137@canb.auug.org.au> <5332FE45.5030601@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <5332FE45.5030601@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Georgi Vlaev <joe@nucleusys.com>, Brian Austin <brian.austin@cirrus.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 09:20 AM, Randy Dunlap wrote:
> On 03/25/2014 11:35 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> This tree still fails (more than usual) the powerpc allyesconfig build.
>>
>> Changes since 20140325:
>>
> 
> on x86_64:
> 
> when CONFIG_INPUT=m and
> SNC_SOC_CS42L42=y:

              L52

> 
> sound/built-in.o: In function `cs42l52_beep_set':
> cs42l52.c:(.text+0xd4b01): undefined reference to `input_event'
> sound/built-in.o: In function `cs42l52_probe':
> cs42l52.c:(.text+0xd4beb): undefined reference to `devm_input_allocate_device'
> cs42l52.c:(.text+0xd4d0c): undefined reference to `input_register_device'
> sound/built-in.o: In function `wm8962_beep_set':
> wm8962.c:(.text+0x116240): undefined reference to `input_event'
> sound/built-in.o: In function `wm8962_probe':
> wm8962.c:(.text+0x116cae): undefined reference to `devm_input_allocate_device'
> wm8962.c:(.text+0x116e0e): undefined reference to `input_register_device'
> 
> 
> Full randconfig file is attached.
> 

I think that this can be fixed by modifying the Kconfig file with:

	depends on INPUT || INPUT=n

This will restrict CS42L52 to =m if INPUT=m.

-- 
~Randy
