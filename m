From: Andrew Gaydenko <a@etver.com>
Subject: Re: alsa + midi == system hangs
Date: Mon, 23 Aug 2004 14:12:06 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408231412.06514@goldspace.net>
References: <200408230108.44078@goldspace.net> <s5hu0uu8atz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0uu8atz.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

The second card is used with intel8x0 driver.

Andrew
======= On Monday 23 August 2004 13:26, you wrote: =======
At Mon, 23 Aug 2004 01:08:44 +0400,
Andrew Gaydenko wrote:
> 
> Hi,
> 
> I have tried to get an answer from the alsa users mailng list without success.
> My last hope is here.
> 
> The problem is very simple: while trying to start any midi-related
> application (rosegarden, qsynth, fluid itself, MuseScore-from-CVS, ...),
> a system hangs absolutely. It seems like:
> 
> - the problem doesn't depend on driver: my friend has another card
>   with the same problem exactly,

Aureon driver has a bug that it probes the MIDI port which doesn't
exist.  This triggered lock-ups.  It was fixed recently on CVS.

Which another driver did cause a similar bug?


Takashi




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
