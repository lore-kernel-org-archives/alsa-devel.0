From: "Merrony, Stephen (London)" <merronys@exchange.uk.ml.com>
Subject: RE: Sequencer API Query
Date: Wed, 5 Feb 2003 10:42:55 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <61627AE0C39BD11182D600805FE6527B0A02D683@lonim26408.uk.ml.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>, "Merrony, Stephen (London)" <merronys@exchange.uk.ml.com>
Cc: 'Clemens Ladisch' <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks - let me know if you want a tester.

Steve

> -----Original Message-----
> From:	Takashi Iwai [SMTP:tiwai@suse.de]
> Sent:	Wednesday, February 05, 2003 10:41 AM
> To:	Merrony, Stephen (London)
> Cc:	'Clemens Ladisch'; alsa-devel@lists.sourceforge.net
> Subject:	Re: [Alsa-devel] Sequencer API Query
> 
> At Wed, 5 Feb 2003 09:48:43 -0000,
> Merrony, Stephen (London) <merronys@exchange.uk.ml.com> wrote:
> > 
> > OK - at least it's not my dodgy programming that's to blame this time
> [;-)
> > 
> > Is it either (i) correct, (ii) safe, or (iii) OK in practice(!),  to
> assume
> > 16 channels per (wavetable) synth?
> 
> (iii).
> if it's 0, it's not defined.  you can assume the 16 channels if the
> port type is a MIDI unless the number is explicitly defined.
> 
> anyway i'll fix the driver to set the correct value.
> 
> 
> Takashi



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
