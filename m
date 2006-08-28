From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Mon, 28 Aug 2006 16:31:04 +0200
Message-ID: <m2veodc4pj.fsf@vador.mandriva.com>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
	<20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
	<20060810213340.A53144FA617@zeus.olymp.home>
	<20060811112018.8j3chcuqg4c444w4@webmail.supelec.fr>
	<20060813214825.5654969E159@zeus.olymp.home>
	<1155554196.1617.268317929@webmail.messagingengine.com>
	<20060820121909.817D6818B4E@zeus.olymp.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060820121909.817D6818B4E@zeus.olymp.home> (Peter Oehry's
	message of "Sun, 20 Aug 2006 14:19:09 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Peter Oehry <peter.oehry@gmx.li>
Cc: alsa-devel@lists.sourceforge.net, Thibault.LeMeur@supelec.fr
List-Id: alsa-devel@alsa-project.org

Peter Oehry <peter.oehry@gmx.li> writes:

> > If the configuration needs to be changed at runtime, and if the
> > driver cannot do this automatically, a mixer control would be the
> > best solution.
> 
> I have some questions to the idea of mixer control:
> - Which controls would be appropriate to select either 16 or 24 Bit?
> - Is it possible to make the restriction that controls can only be
>   changed when the interface is not used?
> 
> The windows driver has the following controls:
> - Check or uncheck each interface [AnIn DigIn AnOut DigOut]
> - Selection of either 16Bit or 24Bit

if you can do it when a mixer element is altered, cannot this be
triggered when the app select 16 or 24bit?
 
> These controls can only be changed if the card is not used. If the
> settings are applied all enpoints are set to altsetting 0 and then
> the used endpoints are configured to the desired altsetting. Is such
> a behaviour possible with alsa mixer controls?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
