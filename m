From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Apr 29 (sound/soc)
Date: Mon, 29 Apr 2013 09:51:19 -0700
Message-ID: <517EA507.203@infradead.org>
References: <20130429191754.8ee71fb814790bf345516ab8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130429191754.8ee71fb814790bf345516ab8@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, alsa <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/29/13 02:17, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130426:
> 


on i386:

CONFIG_I2C=m

sound/built-in.o: In function `snd_soc_codec_set_cache_io':
(.text+0x1ebe4): undefined reference to `regmap_init_i2c'
make[1]: *** [vmlinux] Error 1



-- 
~Randy
