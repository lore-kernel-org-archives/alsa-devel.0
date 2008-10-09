From: Brendan Pike <spike@spykes.net>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 9 Oct 2008 14:12:44 -0400
Message-ID: <20081009141244.712db240@darius>
References: <s5hy70xsl46.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id D2CB424590
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 20:13:02 +0200 (CEST)
In-Reply-To: <s5hy70xsl46.wl%tiwai@suse.de>
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

On Thu, 09 Oct 2008 20:02:01 +0200
Takashi Iwai <tiwai@suse.de> wrote:


> **NOTE**
> The driver is totally untested.  It's just compiled without errors,
> but not reviewed after a quick writing.  So, don't expect it ever runs
> at the first try.  A crash is highly possible.
> 
> There are some build conditions found in sound/pci/sbxfi/sbxfi.c,
> starting with XXX_*.  You can change it if you want.  As default, it's
> for non-fullduplex but accept different rates.  Not sure whether this
> works at all.
> 
> Any test- (and better debugging-) reports are appreciated.
> 
> 
> thanks,
> 
> Takashi

Thank you, will test this later. As coincidental as it seems I pulled my
X-Fi Prelude from my machine last night during cleaning, and never
bothered reinstalling it as I had a bit of lost hope. This is
definitely a huge start.

All of us pushing Creative to release some specs without a ridiculous
NDA would be a big next step.

Cheers,

Bren
