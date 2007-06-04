From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: SALSA-Lib version 0.0.1 release
Date: Mon, 4 Jun 2007 09:19:07 -0700
Message-ID: <20070604091907.6ed9a3cc@jutz-fc6.na.corp.dmxmusic.com>
References: <s5hsl97aj5d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 5076324498
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 18:16:17 +0200 (CEST)
In-Reply-To: <s5hsl97aj5d.wl%tiwai@suse.de>
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

On Mon, 04 Jun 2007 16:28:30 +0200
"Takashi Iwai" <tiwai@suse.de> wrote:

> Hi all,
> 
> I created a small replacement of ALSA-library, mainly for embedded
> systems with limited resources.  The library is named as "SALSA-Lib"
> (too easy, eh?)

dude, u rawk my world! :-) thankyou very much!!!

> It has no plugin layer but only hw layer, thus no sexy features like
> dmix and format conversions are available.  It supports no shiny and
> complex configuration files.  And it supports no sequencer.  The only
> goal of this library is the reduction of the size of library and
> running binaries by inlining functions with direct syscalls.

This has the possibility of being an absolutely marvelous thing.

> The library is designed to be source-level API compatible with the
> normal alsa-lib 1.0.14.  Note that it is _not_ designed to be
> binary-compatible at all, and it will be never so.
> 
> The first released version 0.0.1 is available at:
> 
> 	ftp://ftp.suse.com/pub/people/tiwai/salsa-lib/salsa-lib-0.0.1.tar.bz2
> 
> The package is released under LGPL as well as the original alsa-lib.

I will try and put it to use after i get my current product issue
resolved.

> I've tested it only on i386, and tests on other architectures would be
> greatly appreciated.
> 
> 
> (And, no, I didn't make it on HG tree yet.)
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
