From: Mark Knecht <markknecht@attbi.com>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L -
	where's Waldo?)
Date: 21 Mar 2003 09:40:59 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048268460.11156.12.camel@Wizard>
References: <1048254648.3400.24.camel@Wizard>
	<s5h7kasrfaa.wl@alsa2.suse.de>  <1048263429.8624.23.camel@Wizard>
	<1048264752.1305.6.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048264752.1305.6.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-03-21 at 08:39, Justin Cormack wrote:
> On Fri, 2003-03-21 at 16:17, Mark Knecht wrote:
> > Takashi,
> >    I have two sound devices (on-board Via device and an RME HDSP 9652)
> > but I only want to configure the RME. Currently alsaconf finds the RME,
> > attempts to install the drivers, and then the drivers fail saying they
> > cannot find the cards. I had hoped that possibly the log file would give
> > me more information on why. I suppose it will not if it's only for ISA
> > devices. (BTW - alsaconf does find this Via chip and can configure it
> > correctly.)
> 
> You need a more recent version of the driver, probably the cvs version
> for this card. The configurator probably checks the PCI id but not the
> revision nuumber.

Justin,
   Thanks for the reply. It makes sense to me, however, since I use the
PlanetCCRMA flow, and alsa is supplied as an RPM, I have no way (that I
know of) to just get a new driver, compile it and try it out. I need a
new RPM, I think.

   Thanks for the ideas!

Cheers,
Mark



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
