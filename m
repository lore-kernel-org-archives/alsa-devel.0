From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions
 [PATCH]]
Date: Wed, 9 Jul 2003 18:28:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307091824050.16335-100000@pnote.perex-int.cz>
References: <20030709160532.GE1031@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030709160532.GE1031@dbz.icequake.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Jul 2003, Ryan Underwood wrote:

> 
> Hi,
> 
> On Wed, Jul 09, 2003 at 02:39:58PM +0200, Takashi Iwai wrote:
> > > 
> > > You are correct, play works correctly but catting does not.  It seems,
> > > however, that many OSS drivers support cat a wav file directly to /dev/dsp,
> > > and do the detection of the format parameters internally.  I guess this is not
> > > required by the OSS specification?
> > 
> > really do _many_ oss drivers support these features?
> > i've never thought of that...
> 
> Every one I've used has done so (Aureal Vortex2, CS4614, c-media, etc).
> I don't know if it's the rule but it seems like fairly common behavior
> from my experience.
> 
> In any case it's really not a big deal, just that ALSA's OSS emulation
> seems to be divergent from the typical OSS driver's behavior in that
> regard.

Show me a wav header parser code in these drivers. I guess that you are 
a bit confused. The standard parameters are 8000Hz, mono, 8-bit unsigned 
(/dev/dsp) or 8000Hz, mono, 16-bit unsigned (/dev/dsp16) or 8000Hz, 
mono, muLaw (/dev/audio) as far as I work with sound drivers since 1994.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
