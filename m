From: John Rigg <ad@sound-man.co.uk>
Subject: Re: envy24control with Hoontech C-Port
Date: Fri, 4 Aug 2006 16:30:51 +0100
Message-ID: <20060804153051.GA2642@localhost.localdomain>
References: <200608030724.16351.songshop@bizmedia.com.au>
	<200608040739.05362.songshop@bizmedia.com.au>
	<s5hy7u4vnn8.wl%tiwai@suse.de>
	<200608042014.12404.songshop@bizmedia.com.au>
	<s5hslkcvkzi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hslkcvkzi.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Geoff Beasley <songshop@bizmedia.com.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 04, 2006 at 12:44:17PM +0200, Takashi Iwai wrote:
> At Fri, 4 Aug 2006 20:14:12 +1000,
> Geoff Beasley wrote:
> > 
> > sure; i understand that. ;) 
> > 
> >  i thought the sync "led" would also apply for the spdif sync as well. no?
> 
> I'm not sure what "led" means.  The fix was to change the control
> element types for the latest drivers, and the feature wasn't changed
> at all by that patch.

Sync LED? My Delta 1010s don't have anything like that. The only
indication that clocks are synced via S/PDIF is that jackd will
run with the S/PDIF cable plugged in and it will show a slew of xruns
(and eventually die) when the cable is unplugged.

IIRC Doug's fix was just to allow S/PDIF sync to work with the Delta
1010LT (it already worked for the Delta 1010). I don't think he got
round to fixing sync via wordclock input for the 1010LT (that works for
the Delta 1010 but not Delta 1010LT AFAIK).

BTW the Delta 1010 does have an indicator in envy24control that shows
when the clock is synced to wordclock input - could this be the "led"
referred to?

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
