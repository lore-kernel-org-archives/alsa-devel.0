From: Frank Barknecht <fbar@footils.org>
Subject: Re: After warm boot Alsa not detecting sound card
Date: Tue, 4 Nov 2003 10:41:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031104094152.GB32134@fliwatut.scifi>
References: <1067832822.2011.8.camel@Wizard.knechthome.com> <1067893471.24188.135.camel@cmn37.stanford.edu> <1067906797.1831.9.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1067906797.1831.9.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hallo,
Mark Knecht hat gesagt: // Mark Knecht wrote:

> # OSS/Free portion - card #1 (HDSP9652)
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> 
> # OSS/Free portion - card #2 (MidiSport 2x2)
> alias sound-service-1-0 snd-mixer-oss
> alias sound-service-1-1 snd-seq-oss
> alias sound-service-1-3 snd-pcm-oss
> alias sound-service-1-8 snd-seq-oss
> alias sound-service-1-12 snd-pcm-oss

You don't need to define snd-seq-oss for the second card, as there is
only one sequencer device anyway, and that includes both cards. You
probably also don't need snd-mixer and snd-oss for the 2x2, because
the Midisport does no audio, or does it?

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
