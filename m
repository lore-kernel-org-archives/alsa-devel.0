From: Tim <terminator356@users.sourceforge.net>
Subject: Re: ice1712 IPGA and ADC controls
Date: Thu, 1 Feb 2007 05:01:21 +0000 (UTC)
Message-ID: <loom.20070201T053544-384@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
	<20070127123807.GA2662@localhost.localdomain>
	<200701282259.52583.gineera@aspect135.co.uk>
	<s5h7iv61116.wl%tiwai@suse.de>
	<20070129191551.GA2673@localhost.localdomain>
	<loom.20070130T064723-509@post.gmane.org>
	<s5hac00ojg0.wl%tiwai@suse.de>
	<loom.20070131T000127-424@post.gmane.org>
	<s5h8xfjvay6.wl%tiwai@suse.de> <s5h1wlbv62t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes (er... draws): 
 
>     +---+ +18dB 
>     |   | 
>     |   | analog 
>     |   | gain 
>     |   | 
>     +---+ 0dB 
>     |   | 
>     |   | digital 
>     |   | att  
>     |[=]--[ -30dB ] 
>     |   | 
>     +---+ -64dB 
>  
 
My, what lovely ascii art. But who will port envy24control to ncurses?  
Yeah, that's it, kinda.  
 
Also my Delta1010's Windows driver mixer-app has  
 db numbers on the monitor mixer tab's vu meters. 
 
Curiously, a quote from my manual about the Windows mixer-app: 
 
 "The (dac/adc) faders can be set incrementally in 0.5db steps, 
  of which there are 18." 
 
I'm scratching my head - what the heck do they mean by 18 0.5db steps?  
That's not nearly enough to cover the range! 
And looking at IPGA gain table of the chip, I wonder how they would  
 accomplish that. The specific db steps of each level are very unusual  
 and follow a pseudo-log scheme, and in many places an exact 0.5db 
 step doesn't look possible. 
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
