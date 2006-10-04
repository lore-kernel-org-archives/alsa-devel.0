From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [alsa-cvslog] alsa-kernel: emu10k1: Fix
	outl()	in	snd_emu10k1_resume_regs()
Date: Wed, 4 Oct 2006 20:33:22 +0300
Message-ID: <20061004173322.GA269@sci.fi>
References: <ALOGGER1159978767.86@alsa-project.org>
	<4523DFF2.4020105@superbug.co.uk> <s5hfye4jbdb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hfye4jbdb.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 04, 2006 at 06:26:24PM +0200, Takashi Iwai wrote:
> At Wed, 04 Oct 2006 17:23:14 +0100,
> James Courtier-Dutton wrote:
> > =

> > Takashi Iwai wrote:
> > > -		outl(emu->port + A_IOCFG, emu->saved_a_iocfg);
> > > -	outl(emu->port + HCFG, emu->saved_hcfg);
> > > +		outl(emu->saved_a_iocfg, emu->port + A_IOCFG);
> > > +	outl(emu->saved_hcfg, emu->port + HCFG);
> > >   =

> > Is there any tool to find out who got this wrong in the first place?
> =

> One could check whether the argument is long or not.  The long is
> likely an i/o port while the data is int or unsigned int.
> But, C allows implicit conversion, so the compiler would never
> complain...

Using sparse should help in avoiding this kind of bug.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
