From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [RFC] re-queuing usx2y-fw
Date: Fri, 1 Apr 2005 13:16:11 +0200
Message-ID: <20050401111611.GC7037@tuba>
References: <20050328155151.GA3552@tuba> <s5hfyyeijh8.wl@alsa2.suse.de> <20050329165816.GA2696@tuba> <s5h7jjqidv3.wl@alsa2.suse.de> <20050331115848.GA13462@tuba> <m2acoj950i.fsf@vador.mandrakesoft.com> <20050401103348.GB7037@tuba> <s5hk6nmepkn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 2693C239
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 13:15:33 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hk6nmepkn.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 01, 2005 at 12:52:56PM +0200, Takashi Iwai wrote:
> At Fri, 1 Apr 2005 12:33:48 +0200,
> Martin Langer wrote:
> > On Thu, Mar 31, 2005 at 06:03:41PM +0200, Thierry Vignaud wrote:
> > > Martin Langer <martin-langer@gmx.de> writes:
> > > 
> > > > http://wiki.erazor-zone.de/doku.php?id=wiki:projects:linux:as31
> > > 
> > > why not auto enabling it if we detect the non free as31 rather than
> > > just providing such flag?
> > 
> > Is it really necessary to build it by default? I see a lot of trouble at 
> > the horizon due to version mismatches of as31. An as31 version check 
> > could solve it, though.
> 
> Agreed.  The resultant firmware should be 100% identical even if you
> build by yourself.  Hence I don't think it's needed so much.

Controlling a checksum could solve that. md5sum? That would result in a 
table of as31 version and their related checksum. If someone wants to 
write it, go ahead :)

martin


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
