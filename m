From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: How do I make -D hw:0,1 default?
Date: Tue, 3 Jun 2003 20:58:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306032055430.1174-100000@pnote.perex-int.cz>
References: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Jun 2003, Mark Knecht wrote:

> > > .asoundrc from Alsa site:
> > >
> > >         pcm.via82xx {
> > >            type hw
> > >            card 0
> > >         }
> > >
> > >         ctl.via82xx {
> > >            type hw
> > >            card 0
> > >         }
> > >
> > > Maybe I need to include the ',1' interface somehow? How would I do that?
> >
> > Add 'device 1' to {} section.
> >
> > 						Jaroslav
> 
> Thanks Jaroslav!
> 
> Will this make device 1 default for all applications that require sound but
> do not ask for anything specific in terms of interfaces?

The applications should use 'default' device name in that case. You can 
override it, of course:

pcm.!default {
	... put your configuration here ...
}

You will propably copy pcm.via82xx configuration.

Or you can redirect the default device to some another pcm:

pcm.!default pcm.via82xx

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
