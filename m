From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Tascam US-122: tascam_firmware-0.1 and alsa-firmware
Date: Thu, 27 Nov 2003 20:24:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031127192437.GA561@tuba.home>
References: <3FC60BAA.4060809@laposte.net> <200311271556.36745.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200311271556.36745.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: JoDaY <jo.day@laposte.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 27, 2003 at 03:56:36PM +0100, Karsten Wiese wrote:
> Am Donnerstag, 27. November 2003 15:35 schrieb JoDaY:
> >
> > But I can't see it in any mixer: alsamixer return No mixer elems found.
> there is no mixer support yet. but it is certainly implementable ;-)
> 

The mixer is implemented in the hardware: some knobs for changing input or 
output level and a switch for changing the input source! It's absolutely
mixerless on the sw side and the windows driver is also mixerless (IIRC).

Finally: Play/Record/MIDI will work without such software mixer!

martin


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
