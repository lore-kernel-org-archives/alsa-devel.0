From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: ICE1712: no volume range inversion for AK4528/4524
Date: 08 Dec 2002 15:42:10 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1039390992.30154.14.camel@cmn37.Stanford.EDU>
References: <Pine.LNX.4.33.0212071044350.552-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212071044350.552-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > > I also noticed that the adc controls have a weird behavior (in a
> > > > delta66). I start both alsamixer and envy24control. I can control the
> > > > adc volume for each channel from both of them. I can quit and restart
> > > > alsamixer and everything is fine. If I quit and restart envy24control
> > > > all adc volumes go up to 127 (which is, at this point, 0 volume). 
> > > 
> > > It looks like a envy24control problem. Please, report, if this problem 
> > > persists with updated driver.
> > 
> > Yes, it is the same. It happens only for all four adc controls, the dac
> > controls are "remembered" correctly. On startup envy24control sets all
> > adc volume controls to max volume. 
> 
> It should be definitely fixed by Dirk Kalis now. Please, try CVS sources.

It is fixed now. Thanks Dirk and Jaroslav a lot for the fast fix!
-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
