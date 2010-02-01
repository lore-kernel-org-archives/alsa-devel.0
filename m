From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 10/10] sound/soc/blackfin: Fix continuation line formats
Date: Mon, 01 Feb 2010 09:08:00 -0800
Message-ID: <1265044080.25140.266.camel@Joe-Laptop.home>
References: <cover.1264967493.git.joe@perches.com>
	 <aee58f4fc07709fe8a34021899e701824a0a6b53.1264967500.git.joe@perches.com>
	 <20100201144745.GC26011@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100201144745.GC26011@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-02-01 at 14:47 +0000, Mark Brown wrote:
> On Sun, Jan 31, 2010 at 12:02:12PM -0800, Joe Perches wrote:
> > String constants that are continued on subsequent lines with \
> > are not good.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Gah, I thought I'd caught most of these when reviewing.  If you're using
> a script to pick this stuff up it'd be worth checking for extraneous
> continuations in the middle of code - outside of macros there's little
> call for it.
> 
> Applied, thanks.

There are a few false positives and probably a few missing using

        grep -rP --include=*.[ch] '".*\\$' * | \
        awk '{ if ((gsub("\"", "\"") % 2) == 1) print $0; }'
        
Most of the uses are __asm__ __volatile__ which could be
considered unsightly but don't impact logging messages.

The rest could/should be fixed.
