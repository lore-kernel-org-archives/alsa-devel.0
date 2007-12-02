From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: multi pcm and mmap problem
Date: Sun, 2 Dec 2007 13:40:11 +0000
Message-ID: <20071202134011.GA2956@localhost>
References: <200711210158.42108.terminator356@users.sourceforge.net>
	<200711261746.59712.terminator356@users.sourceforge.net>
	<s5habozkcks.wl%tiwai@suse.de>
	<200712011833.36219.terminator356@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id D3495103896
	for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2007 14:33:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712011833.36219.terminator356@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim <terminator356@users.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 01, 2007 at 06:33:35PM -0500, Tim wrote:
> Takashi, after a week of testing your multi-plughw patch 
>  I'm satisfied it works fine.
> 
> One odd thing is that when I start Jack, sometimes I 
>  immediately get a series of ever increasing xruns,
>  sometimes hundreds of them with each display update of QJackctl.
> Simply restarting QJackctl cures it and it runs for many hours 
>  without trouble.
> I am not convinced it has anything to do with your patch,
>  maybe just my new .asoundrc and new altered setup.

It's a known problem with pcm_multi and qjackctl. qjackctl reports
xruns that aren't actually happening when using pcm_multi. Some
other apps like jamin do this too. Don't worry about it unless you
hear dropouts (in which case the alsa driver will report a real xrun).

John
