From: Grzesiek Sedek <grzesiek@mi2.hr>
Subject: Re: ALSA ../alsa-kernel/ppc/keywest.c:84:
	tumbler:	cannot initialize the MCS
Date: 02 Jul 2003 14:35:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057152909.7730.11.camel@localhost>
References: <1056815454.1175.2.camel@localhost>
	 <s5hsmprlns0.wl@alsa2.suse.de> <1056979019.3742.8.camel@localhost>
	 <s5hy8zhji0s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8zhji0s.wl@alsa2.suse.de>
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

I did try dmasound-pmac some days ago and it seem to load with no errors
(I'm not sure about it - I'll load it again and check) but there was no
sound from xmms or pd. only one unusual thing I've noticed was "beep"
when ibook go to sleep - indicating that oss sound driver was in fact
loaded and working (at least partly). This is under alsa 0.9.4 and
kernel 2.4.21-ben2 with kernel 2.4.20-ben10 and alsa 0.9.1 everything is
ok.    

On Wed, 2003-07-02 at 12:16, Takashi Iwai wrote:
> At 30 Jun 2003 14:17:00 +0100,
> Grzesiek Sedek wrote:
> > 
> > Yes both i2c-keywest and i2c-core are build and loaded.
> > I'm really puzzled-I never had any problems like that. I've build few
> > kernels since alsa stopped using old working .config's and still no
> > luck.
> 
> could you check dmasound-pmac driver whether it can be loaded
> properly?  if it's ok, i can compare with it.
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
