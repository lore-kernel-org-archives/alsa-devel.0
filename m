From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: ICE1712: no volume range inversion for AK4528/4524
Date: 06 Dec 2002 12:38:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1039207092.725.45.camel@cmn37.Stanford.EDU>
References: <Pine.LNX.4.33.0212060930200.527-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212060930200.527-100000@pnote.perex-int.cz>
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

> > > The volume range inversion is ok for the AK4529/Delta410 (to increase 
> > > volume when pulling up the faders).
> > > But AK4528 (and AK4524) don't need the inversion (sliders worked 
> > > correctly before Jaroslav's patch).
> > 
> > I have just rebuilt the alsa drivers from cvs and the volume controls in
> > current cvs are inverted for a plain Delta 66 card. 
> 
> Could you give a next try?

The dac/adc volume controls for the delta66 are now correct, thanks!

> > I also noticed that the adc controls have a weird behavior (in a
> > delta66). I start both alsamixer and envy24control. I can control the
> > adc volume for each channel from both of them. I can quit and restart
> > alsamixer and everything is fine. If I quit and restart envy24control
> > all adc volumes go up to 127 (which is, at this point, 0 volume). 
> 
> It looks like a envy24control problem. Please, report, if this problem 
> persists with updated driver.

Yes, it is the same. It happens only for all four adc controls, the dac
controls are "remembered" correctly. On startup envy24control sets all
adc volume controls to max volume. 

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
