From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Can't set 88.2/96kHz samplerate with Hammerfall
Date: Thu, 4 Dec 2003 09:43:36 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGKEECECAB.mknecht@controlnet.com>
References: <oprzooeppwq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprzooeppwq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >
> > From the Hammerfall Light Alsa sound card page:
> >
> > Known bugs
> >
> > - 96kHz and 88.2kHz not accessible via PCM interface
> Ok, thanks. I suppose I should've investigated a little better.
> Too bad, I
> would like to see this card working as well as under Windows.
>
> Regards
>
> Arve Knudsen

Me too. I own the same card in one of my systems. This is really the
downside to Linux audio. Without dedicated developers that own the cards and
continue working on improvements support stalls out. The best I've been able
to determine is that this card last got a real facelift over a year ago and
since then nothing. I've grown to accept that it will never happen, and will
be overjoyed that was if and when it finally does. Don't expect anything
soon, unless you're willing to be that developer.

BTW - if you get a chance, take a look at /proc/asound/card0/hdsp  (modify
the card number if required and I'm guessing on the hdsp part) and see if
it's listing spdif under the status section? Mine doesn't, or didn't, the
last time I looked. It indicated 3 ADAT ports which this card does not have.

- Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
