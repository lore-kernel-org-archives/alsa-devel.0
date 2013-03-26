From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 26 (snd/soc/codecs)
Date: Tue, 26 Mar 2013 13:40:15 -0700
Message-ID: <515207AF.8070808@infradead.org>
References: <20130326174214.27b644d00421bae4c8d3cf3b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130326174214.27b644d00421bae4c8d3cf3b@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/25/13 23:42, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130325:
> 


on i386:

sound/built-in.o:(.rodata+0xeb9d0): undefined reference to `arizona_rate_text'
sound/built-in.o:(.rodata+0xeb9d4): undefined reference to `arizona_rate_val'
sound/built-in.o:(.rodata+0xeb9e8): undefined reference to `arizona_rate_text'
sound/built-in.o:(.rodata+0xeb9ec): undefined reference to `arizona_rate_val'
sound/built-in.o:(.rodata+0xeba00): undefined reference to `arizona_rate_text'
sound/built-in.o:(.rodata+0xeba04): undefined reference to `arizona_rate_val'
sound/built-in.o:(.rodata+0xeba18): undefined reference to `arizona_rate_text'
sound/built-in.o:(.rodata+0xeba1c): undefined reference to `arizona_rate_val'


CONFIG_SND_SOC_WM_ADSP=y
but CONFIG_SND_SOC_ARIZONA is not enabled.





-- 
~Randy
