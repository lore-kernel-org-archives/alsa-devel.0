From: rct@frus.com (Bob Tracy)
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 12 Mar 2008 15:31:50 -0500 (CDT)
Message-ID: <20080312203150.80E01DBA2@gherkin.frus.com>
References: <47D8304C.3090005@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <47D8304C.3090005@keyaccess.nl> "from Rene Herman at Mar 12, 2008
 08:34:36 pm"
Sender: linux-alpha-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bob Tracy <rct@frus.com>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> (Re: interrupts not being seen by es18xx)
> That is indeed what it soundeed like, or the first bit at least.
> 
> What does cat /proc/config.gz | grep CONFIG_ALPHA_ say? Miuchael, and for 
> you? For some Alpha configs, arch/alpha/kernel/es1888.c is compiled and for 
> some not. I expect for you (Bob) it's compiled in? And Michael?

Here is the requested list of CONFIG_ALPHA_* items for the
2.6.25-rc4+iommu_patch kernel with support for snd-es18xx and snd-sb8:

CONFIG_ALPHA=y
CONFIG_ALPHA_MIATA=y
CONFIG_ALPHA_EV5=y
CONFIG_ALPHA_CIA=y
CONFIG_ALPHA_EV56=y
CONFIG_ALPHA_PYXIS=y
CONFIG_ALPHA_SRM=y
CONFIG_ALPHA_LEGACY_START_ADDRESS=y

>From arch/alpha/kernel/Makefile, obj-${CONFIG_ALPHA_MIATA} adds es1888.o
as a built-in object, so yes, it's built-in.

I never noticed the init support for the ES1888 chip before...  The code
appears to set up DMA channel 1, but does not mention anything about the
second 16-bit DMA channel.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
