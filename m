From: Peter Enderborg <pme@ufh.se>
Subject: Re: Rawmidi bug or missed feature?
Date: Fri, 01 Mar 2002 23:18:18 +0100
Message-ID: <3C7FFE29.698B64E1@ufh.se>
References: <200203012131.QAA26852@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

> >Yes! And the device that is using running status is alsa rawmidi device.
>
> What makes you think that? AFAIK, the raw MIDI device code does no
> parsing of MIDI data at all ...

Parsing? It sends raw midi on a stream. That stream is _from_ alsa seq. It is
doing
the bandwith optimize by it self. I do the parsing.

>
>
> >It's not the roland device since I
> >get them correct to the user_code.  And how do I force the rawmidi device
> >to stop sending running status,
> >and that is the original question!
>
> I would have thought that if its not the Roland that is doing it, then
> its the sequencer.
>
> --p

--
foo!




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
