From: Tobias Klausmann <klausman-alsa@schwarzvogel.de>
Subject: Re: Audinst HUD-mx2 covertly muting itself
Date: Fri, 1 Nov 2013 14:58:39 +0100
Message-ID: <20131101135839.GA90732@skade.schwarzvogel.de>
References: <20131031101137.GA75354@skade.schwarzvogel.de>
 <52727D15.90907@ladisch.de>
 <20131031161517.GA53495@skade.schwarzvogel.de>
 <52728486.2060506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.schwarzvogel.de (skade.schwarzvogel.de [144.76.18.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DC702657B7
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 14:58:39 +0100 (CET)
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.82)
 (envelope-from <klausman@schwarzvogel.de>) id 1VcFFH-000OGk-BE
 for alsa-devel@alsa-project.org; Fri, 01 Nov 2013 14:58:39 +0100
Content-Disposition: inline
In-Reply-To: <52728486.2060506@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi! 

On Thu, 31 Oct 2013, Clemens Ladisch wrote:
> Tobias Klausmann wrote:
> > I have gotten a temporary workaround: use the secondary PCM
> > device (hw:0,1) instead of the primary (hw:0,0)
> 
> Oops, I didn't notice that there are two devices.
> 
> The first PCM device is only for Dolby-encoded data, so muting the
> analog output would be correct.
> 
> > Maybe something along the lines of PCI device "quirks" would be
> > the right thing to do? I.e. swapping the two PCM devices from
> > ALSA's point of view.
> 
> The driver should never make the non-PCM device the first one.

My concern is just that I have found at least 5 different forum,
blog and mailing list posts where people were unable to diagnose
this or fix it. There was exactly one thread that shed light:

http://comments.gmane.org/gmane.linux.alsa.devel/109855

The fix (using hw:0,1 as default) is not obvious to the average
person and sort-of forcing them to dig around the internet and
happen upon that thread strikes me as not exactly user friendly.

Don't get me wrong, I understand that the way things are has
mostly to do with the myriad of ways in which USB audio devices
are built. But making it easy/easier for user to get them working
properly "out of the box" seems worthwile.

Regards,
Tobias
