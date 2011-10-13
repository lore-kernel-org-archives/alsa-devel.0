From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [alsa-devel] linux-next: Tree for Oct 12 (sound/soc/codecs/wm1250-ev1)
Date: Thu, 13 Oct 2011 11:28:49 -0700
Message-ID: <4E972DE1.9020308@xenotime.net>
References: <20111012175425.a2e3e6e6a92265e433aeca25@canb.auug.org.au> <4E9634C9.3020404@xenotime.net> <20111013102427.GG1098@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111013102427.GG1098@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/13/2011 03:24 AM, Mark Brown wrote:
> On Wed, Oct 12, 2011 at 05:46:01PM -0700, Randy Dunlap wrote:
> 
>> When no GPIO kconfig options are enabled:
>> (not GPIOLIB, not GENERIC_GPIO):
> 
> As ever the consumer side GPIO API is supposed to stub itself out when
> not in use.

You are listed as MODULE_AUTHOR().  Can we expect a fix?

I don't see how stubs help with source lines like:
struct wm1250_priv {
	struct gpio gpios[WM1250_EV1_NUM_GPIOS];
};

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
