From: Dave Jones <davej@redhat.com>
Subject: Re: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Date: Tue, 4 Oct 2005 16:40:34 -0400
Message-ID: <20051004204034.GA23748@redhat.com>
References: <dc7e3d7c111741a991e11a1a39ca9262@pobox.sk> <434261F9.4020708@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1218F194
	for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2005 22:40:37 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <434261F9.4020708@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2005 at 12:05:29PM +0100, James Courtier-Dutton wrote:

 > In my view the patch as presented is the correct behaviour.

Clearly you aren't one of the affected users now unable to adjust
the volume on their sound cards.

 > We are aiming to identify every sound card using it's PCI subversion 
 > IDs.

Which is flawed due to the ID clash between the two cards.
What the patch is doing is saying "Oops, there's a problem with
this approach, lets stick our heads in the sand and pretend it
isn't there" instead of trying to come to some compromise to
allow both sets of cards to work.

I'm glad the Audigy is now working. However, we should not make
one card work by breaking another.

 > This information is vital for us 
 > developers when we get reports of Audigy card X  not working, as every 
 > single Audigy card has slight but very important differences that can 
 > only be detected via the PCI subversion IDs.

At the expense of users of working SBLive 5.1 setups.
user: "Where have my sblive volume sliders gone?"
me  : "Oh, that's intentional so that we can identify Audigy's"
user: "wtf?"

 > This patch will therefore only 
 > effect 2 sound cards, and therefore has minimal impact on all the other 
 > sound cards currently recognised.

One of those models is now effectively useless however.

 > It is always better to try and 
 > autodetect hardware features, than require a new module parameter, so 
 > adding a module parameter is not a viable option here.

We obviously *can't* autodetect between the two here, unless you add
some additional checks (PCI revision field perhaps?).

 > We already have a 
 > module parameter to force the driver to bypass is PCI subversion ID 
 > recognition and assume a different card id so when a new sound card 
 > appears, the user can work around the recognition problem until the 
 > recognition is added to the driver.
 
The recognition isn't the issue, I couldn't care less if the driver
called it a soundblaster moonunit, all I (and quite a few users judging
by bugzilla) care about is whether the thing works.

		Dave



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
