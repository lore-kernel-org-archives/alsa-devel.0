From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ICE1712: no volume range inversion for AK4528/4524
Date: Fri, 6 Dec 2002 09:31:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212060930200.527-100000@pnote.perex-int.cz>
References: <1039143257.5128.74.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1039143257.5128.74.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 5 Dec 2002, Fernando Pablo Lopez-Lezcano wrote:

> > The volume range inversion is ok for the AK4529/Delta410 (to increase 
> > volume when pulling up the faders).
> > But AK4528 (and AK4524) don't need the inversion (sliders worked 
> > correctly before Jaroslav's patch).
> 
> I have just rebuilt the alsa drivers from cvs and the volume controls in
> current cvs are inverted for a plain Delta 66 card. 

Could you give a next try?

> I also noticed that the adc controls have a weird behavior (in a
> delta66). I start both alsamixer and envy24control. I can control the
> adc volume for each channel from both of them. I can quit and restart
> alsamixer and everything is fine. If I quit and restart envy24control
> all adc volumes go up to 127 (which is, at this point, 0 volume). 

It looks like a envy24control problem. Please, report, if this problem 
persists with updated driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
