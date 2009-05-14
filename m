From: "Michael (Micksa) Slade" <mslade@knobbits.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Thu, 14 May 2009 22:07:33 +1000
Message-ID: <4A0C0985.9040004@knobbits.org>
References: <s5h4ovovtwe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from killface.knobbits.org (killface.knobbits.org [67.18.208.22])
	by alsa0.perex.cz (Postfix) with ESMTP id A60912439C
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 14:07:44 +0200 (CEST)
In-Reply-To: <s5h4ovovtwe.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> Hi,
>
> after some communications with Creative, I finally got a mergeable
> version of their X-Fi driver.  It's not my crappy hack but by genuine
> Creative :)
>
> The patch is now merged into sound-unstable GIT tree topic/ctxfi
> branch:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
>
> The corresponding alsa-driver snapshot tarball is:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
Woo, worked first go! :)

I have a "Titanium fata1ity Pro" (1102:000b/1102:0043), and compiled 
against Intrepid's current kernel (2.6.28-11).

I have only recently subscribed to the list and was just about to ask 
what the deal was with the X-Fi driver.

So mplayer, aplay and audacious all play things.  Clearly works 
perfectly then :)

Does alsa have some sort of test suite or similar that I can run the 
card through?

Mick.
