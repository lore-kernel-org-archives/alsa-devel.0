From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 24 Aug 2004 08:01:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040824060114.GA18050@sunrise.pg.gda.pl>
References: <20040818181350.2b38e875@mango.fruits.de> <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz> <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz> <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz> <4129D6A2.7020801@pg.gda.pl> <Pine.LNX.4.58.0408231349520.1801@pnote.perex-int.cz> <4129E473.6070702@pg.gda.pl> <Pine.LNX.4.58.0408231633260.1801@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BE0CA295
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2004 08:01:20 +0200 (MEST)
Received: from sunrise.pg.gda.pl (atlka@localhost [127.0.0.1])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i7O61JaX027110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2004 08:01:19 +0200 (CEST)
Received: (from atlka@localhost)
	by sunrise.pg.gda.pl (8.12.11/8.12.11/Submit) id i7O61Egx027105
	for alsa-devel@alsa-project.org; Tue, 24 Aug 2004 08:01:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408231633260.1801@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 23, 2004 at 04:39:20PM +0200, Jaroslav Kysela wrote:
> Quake is special case. For standard applications, the mixing should be 
> provided, but there're not latency issues.
OK - but some old apps use DMA ring buffer and they should work properly
too.

> 
> I still think that the aoss library can be fixed so that quake will work.
> I think that OSS/Commercial also adds some delay on their "virtual" 
> devices mixed together.
Sure but aoss sometimes produces clicks and bad sound effects.
Switching to other app and then returning to previous one helps.
I have patched aoss which plays quake1 - quake3 in MMAP mode
but it is not perfect. Also some apps which use poll don't work
at all (old game Shogo) - SDL report timing problems and disables
sound.
aoss approach doesn't work at all with apss which are completly static
or disabling LD_PRELOAD.

> Why not? Most today's hardware can reroute samples or analog paths in 
> hardware. So it's only about right mixer setup.
As I said before I dont want to buy expensive mambo-jubo card just 
to mix stereo, mono and 5.1 sources together at the same time
with the proper up/down sampling, channel volume control
and sound phase correction. I think that driver should use all card
abilities and emulate other in software.
If I put headphones on my head I just want to use one switch in mixer
app to turn on headphones mode. The same in opposite direction.


Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
