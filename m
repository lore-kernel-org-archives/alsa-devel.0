From: Paul Davis <pbd@Op.Net>
Subject: Re: Rawmidi bug or missed feature?
Date: Fri, 01 Mar 2002 16:31:40 -0500
Message-ID: <200203012131.QAA26852@renoir.op.net>
In-reply-to: Your message of "Fri, 01 Mar 2002 22:06:37 +0100."
             <3C7FED5D.8D22FA86@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Yes! And the device that is using running status is alsa rawmidi device.

What makes you think that? AFAIK, the raw MIDI device code does no
parsing of MIDI data at all ...

>It's not the roland device since I
>get them correct to the user_code.  And how do I force the rawmidi device
>to stop sending running status,
>and that is the original question!

I would have thought that if its not the Roland that is doing it, then
its the sequencer. 

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
