From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [patch] alsa-utils fix for intl support
Date: Mon, 8 Dec 2008 10:29:05 +0100
Message-ID: <20081208102905.245d257b@hcegtvedt>
References: <20081204152947.069fd146@hcegtvedt> <s5hhc5fp1et.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id ABE5910380C
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 10:29:07 +0100 (CET)
In-Reply-To: <s5hhc5fp1et.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 08 Dec 2008 08:32:42 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 4 Dec 2008 15:29:47 +0100,
> Hans-Christian Egtvedt wrote:
> > 
> > Hi,
> > 
> > Feel free to comment on the included patch. I had to add it because
> > aseqnet would not link without -lintl.
> 
> Patching Makefile.in doesn't make any sense.
>

I have quite low fu with autoconf, but sure Makefile.in does not need a
patch as well? There are no users of LIBADD in seq/aseqnet/Makefile.in.

> Does the patch below work instead?
> 

Nope, still not able to find libintl.

What is the correct way of testing this? From a fresh 1.0.18 source I
changed seq/aseqnet/Makefile.am and then ran autoreconf
before ./configure + make. Should I have used more/other autotools?

<snipp Makefile.am patch>

-- 
Best regards,
Hans-Christian Egtvedt
