From: Grzesiek Sedek <grzesiek@mi2.hr>
Subject: Re: ALSA ../alsa-kernel/ppc/keywest.c:84: tumbler:
	cannot initialize the MCS
Date: 30 Jun 2003 14:17:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056979019.3742.8.camel@localhost>
References: <1056815454.1175.2.camel@localhost>
	 <s5hsmprlns0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmprlns0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yes both i2c-keywest and i2c-core are build and loaded.
I'm really puzzled-I never had any problems like that. I've build few
kernels since alsa stopped using old working .config's and still no
luck.
Thanks
On Mon, 2003-06-30 at 14:04, Takashi Iwai wrote:
> At 28 Jun 2003 16:50:55 +0100,
> Grzesiek Sedek wrote:
> > 
> > I had my alsa running fine for a while at some point audio stop working
> > (must been afer one of upgrades to 9.4 on debian ppc sid)
> > this is dmesg error I'm getting:
> > 
> > ALSA ../alsa-kernel/ppc/keywest.c:84: tumbler: cannot initialize the MCS
> > 
> > modules are loading ok but no sound.
> > Thanks for any help.
> 
> did you load/build the i2c-keywest driver, too?
> the pmac tumbler/snapper requires this for controlling the chip over
> i2c.
> 
> 
> Takashi
-- 
Grzesiek Sedek <grzesiek@mi2.hr>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
