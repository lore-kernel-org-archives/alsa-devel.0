From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions [PATCH]]
Date: Wed, 9 Jul 2003 11:05:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030709160532.GE1031@dbz.icequake.net>
References: <20030708173229.GG1030@dbz.icequake.net> <s5hd6gkdimp.wl@alsa2.suse.de> <20030708195437.GL1030@dbz.icequake.net> <s5hu19vc1r5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu19vc1r5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

On Wed, Jul 09, 2003 at 02:39:58PM +0200, Takashi Iwai wrote:
> > 
> > You are correct, play works correctly but catting does not.  It seems,
> > however, that many OSS drivers support cat a wav file directly to /dev/dsp,
> > and do the detection of the format parameters internally.  I guess this is not
> > required by the OSS specification?
> 
> really do _many_ oss drivers support these features?
> i've never thought of that...

Every one I've used has done so (Aureal Vortex2, CS4614, c-media, etc).
I don't know if it's the rule but it seems like fairly common behavior
from my experience.

In any case it's really not a big deal, just that ALSA's OSS emulation
seems to be divergent from the typical OSS driver's behavior in that
regard.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
