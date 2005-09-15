From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Thu, 15 Sep 2005 17:35:33 +0300
Message-ID: <20050915143533.GB23218@sashak.softier1.local>
References: <20050911124530.GA16795@titan.lahn.de>
 <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>
 <20050913085552.GA2655@titan.lahn.de>
 <20050913173529.GD31269@sashak.softier1.local>
 <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com>
 <20050914205608.GD14657@sashak.softier1.local>
 <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050915092155.GA7328@titan.lahn.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>, Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 11:21 Thu 15 Sep     , Philipp Matthias Hahn wrote:
> Hello!
> 
> On Thu, Sep 15, 2005 at 11:11:58AM +0200, Philipp Matthias Hahn wrote:
> > On Wed, Sep 14, 2005 at 11:56:08PM +0300, Sasha Khapyorsky wrote:
> > > Philipp, you could play with VORTEX_CODEC_ID_SHIFT value (au88x0,h) in
> > > range 24-31.
> > ...
> > > diff -rpu au88x0_orig/au88x0.h au88x0/au88x0.h
> > ...
> > > +#define VORTEX_CODEC_ID_SHIFT	30 /* unknown: may be 24-31 (or irrelevat) */
> > 
> > Sorry, no luck with any value in the range 24-31.
> 
> Sorry, I wronly patched the driver.
> 24-31/25 works. tar-file with copies of /proc/asound/au8810 attached.

Great, the secondary modem codec is there. The valid codec id bits are
24:25 (AC97 interface supports up to four codecs):

#define VORTEX_CODEC_ID_SHIFT 24

I will send cleaned codec access patch separately and will look what is
next.

BTW, thanks for info alternative drivers (I had question about windows
.inf file syntax, but now with your results it is irrelevant anymore :)).

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
