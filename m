From: Mark Knecht <markknecht@comcast.net>
Subject: Re: After warm boot Alsa not detecting sound card
Date: Tue, 04 Nov 2003 02:22:51 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067941371.1633.4.camel@Wizard.knechthome.com>
References: <1067832822.2011.8.camel@Wizard.knechthome.com>
	 <1067893471.24188.135.camel@cmn37.stanford.edu>
	 <1067906797.1831.9.camel@Wizard.knechthome.com>
	 <20031104094152.GB32134@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031104094152.GB32134@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-11-04 at 01:41, Frank Barknecht wrote:
> Hallo,
> Mark Knecht hat gesagt: // Mark Knecht wrote:
> 
> > # OSS/Free portion - card #1 (HDSP9652)
> > alias sound-service-0-0 snd-mixer-oss
> > alias sound-service-0-1 snd-seq-oss
> > alias sound-service-0-3 snd-pcm-oss
> > alias sound-service-0-8 snd-seq-oss
> > alias sound-service-0-12 snd-pcm-oss
> > 
> > # OSS/Free portion - card #2 (MidiSport 2x2)
> > alias sound-service-1-0 snd-mixer-oss
> > alias sound-service-1-1 snd-seq-oss
> > alias sound-service-1-3 snd-pcm-oss
> > alias sound-service-1-8 snd-seq-oss
> > alias sound-service-1-12 snd-pcm-oss
> 
> You don't need to define snd-seq-oss for the second card, as there is
> only one sequencer device anyway, and that includes both cards. You
> probably also don't need snd-mixer and snd-oss for the 2x2, because
> the Midisport does no audio, or does it?

You are exactly correct. I removed those last evening. It doesn't seem
to change what drivers get loaded at all, and it doesn't fix my problem.
I still cannot do a warm boot and get Alsa to load correctly.

Have the developers considered Fernando's comments about the startup
scripts before? I don't know, but they seem to the point.

Anyway, with all 5 lines removed I seem to get the same things loaded as
per lsmod's output, and I seem to have the same problems, so this is not
the answer. None the less, I'm happy to try and use Alsa the way the
developers intended it.

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
