From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Sat, 02 Sep 2006 23:40:00 +0200
Message-ID: <44F9FA30.50602@p54A1AFE0.dip0.t-ipconnect.de>
References: <200609010118.k811I1KU028677@auster.physics.adelaide.edu.au>	
	<44F8767E.4050203@p54A1ACFB.dip0.t-ipconnect.de>	
	<44F9605E.3000404@p54A184AE.dip0.t-ipconnect.de>
	<1157224180.19695.10.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1157224180.19695.10.camel@razman>
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

Hello Tobins,

Tobin Davis wrote:
>  Just for grins, could you test the alsa package from RealTek located
> here: 
> ftp://202.65.194.18/pc/hda/alc880d/realtek-linux-audiopack-4.05b.tar.bz2
> 
> I was looking it over, and although it's based on alsa 1.0.9b, there are
> some new differences with the alc250 code (among other things) when
> compared with the alsa-project tip.
> 
> If it works, I'll work on porting their changes into the mainstream.

I already found this package and tested it. I build a diff between alsa
1.0.12 and realtek-linux-audiopack-4.05b.tar.bz2. There are no changes
regarding ALC260 and therefore, there is no difference in behaviour.
BTW: The dirvers are based on ALSA 1.0.12.

I tried it with there alsa-lib 1.0.9 - but this didn't work, too.

I think Maxdata is doing something really nasty, because they use the same
jack for Headphone and S/PDIF out. Maybe, there is a special jack plug
needed? I'm using a standard stereo jack plug.

They must ensure, that the S/PDIF signal doesn't collide with the output
of the analog amplifier (if they have an own). I saw in the datasheet for
the ACL260 chip, that there is a verb with the function SET_EAPD_ENABLE
(-> extern amplifier power down). Maybe, this should be called before
starting SPDIF out (if it's not already done).



Thanks for your hint,
kind regards,
Andreas Hartmann

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
