From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ALSA: atmel: fix building the ac97 driver for at91-multiplatform
Date: Sat, 20 Dec 2014 21:21:10 +0100
Message-ID: <1638172.tTanQ3d90c@wuerfel>
References: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com> <54943BF8.4050008@cogentembedded.com> <20141219170221.GU4885@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141219170221.GU4885@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Alexander Stein <alexanders83@web.de>
List-Id: alsa-devel@alsa-project.org

On Friday 19 December 2014 18:02:21 Alexandre Belloni wrote:
> Arnd,
> 
> On 19/12/2014 at 17:53:44 +0300, Sergei Shtylyov wrote :
> > >+#define cpu_is_at32ap7000() (0)
> > 
> >    () around 0 not needed at all.
> > 
> 
> Do you want me to fix that and resubmit? I don't have strong opinion
> about this.

Yes, no point debating over this. I copied the definition from
arch/arm/mach-at91/include/mach/cpu.h and didn't want to do any
style changes, otherwise I'd probably have turned it into an
inline function, but any version that works is fine with me.

	Arnd
