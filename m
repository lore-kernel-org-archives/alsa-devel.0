From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: hdspmixer issues
Date: Sun, 4 Jul 2004 13:56:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040704135643.030a4d57@laptop>
References: <20040702002259.LHBA27242.smtp3.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040702002259.LHBA27242.smtp3.fuse.net@smtp.fuse.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi ico, hi list...

> I've been messing with hdsp (again :-) and found out that my hdspmixer
> has very oddly behaving sound meters. While the input (2nd row)
> appears to be more or less ok (the yellow peak things kind of fly all
> over the place and often drop off below green lines or even completely
> dissapear), the analog outputs as well as combined monitoring output
> (front 1/4" phono jack on the multiface) only occassionally spike with
> a line input (usually only one channel). I am wondering why this is so
> since the audio is definitely working ok, but the monitoring of the
> outputs simply isn't working (at least not visually).

i've been experiencing similar spikes on the analog outputs as ico
described. since we had a somehow similar problem with screwed up pci
cycles that was caused by incorrect initialisation of the cardbus briges
on our machines, i somehow doubt that it's related to the problem we
had.

cheers...

-- 
mailto:TimBlechmann@gmx.de    ICQ: 96771783

After one look at this planet any visitor from outer space 
would say "I want to see the manager."
				      William S. Burroughs


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
