From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: Detecting ALSA OSS emulation
Date: Mon, 8 Dec 2003 16:16:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031208211652.GG535@zewt.org>
References: <200312081215.hB8CFI1b011127@www7.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200312081215.hB8CFI1b011127@www7.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2003 at 01:15:18PM +0100, p z oooo wrote:
> Probably user has normal soundcard handled by ALSA and TV card
> (btaudio or saa7134) which provides only OSS drivers (warning - only
> recording - not playback). TV card is default /dev/dsp (can by
> changed by module option for btaudio, saa7134). For BT87x users there
> is alsa driver in ALSA 1.0.0rc2 for saa7134 not.

Err, no, this user's configuration didn't have a working ALSA at all.
dsnd_pcm_open returned ENOENT.  His other applications were likely all
using /dev/dsp, too.  However, since /proc/asound/version existed,
my code figured that ALSA was loaded and complained ("/dev/dsp? why
isn't ALSA being used?")

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
