From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Sequencer API Query
Date: Wed, 5 Feb 2003 11:26:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302051125270.1303-100000@pnote.perex-int.cz>
References: <61627AE0C39BD11182D600805FE6527B0A02D681@lonim26408.uk.ml.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <61627AE0C39BD11182D600805FE6527B0A02D681@lonim26408.uk.ml.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Merrony, Stephen (London)" <merronys@exchange.uk.ml.com>
Cc: 'Clemens Ladisch' <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Feb 2003, Merrony, Stephen (London) wrote:

> OK - at least it's not my dodgy programming that's to blame this time [;-)
> 
> Is it either (i) correct, (ii) safe, or (iii) OK in practice(!),  to assume
> 16 channels per (wavetable) synth?

It would be better to use midi_channels() function. Probably SB Live wave 
driver has a bug... We're working on this...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
