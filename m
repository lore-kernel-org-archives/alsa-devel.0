From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Receiving Sequencer Events
Date: Sun, 17 Feb 2002 17:41:12 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202171737440.520-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <XFMail.020217155135.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 17 Feb 2002, Guenther Sohler wrote:

> Hallo List,
>
> I want to receive midi events from my external midi keyboard.
>
> Therefore I tried the seq decoder which comes with the alsa package.
> This application creates a port and when I connect the midi port to this
> listener ports, i can see the events coming from the keyboard.
>
> That means, If i want to receive events, i have to create a port and connect it
> to the source port(external midi "port") - then receive the events with
>
> snd_seq_input_event (not sure whether this is the correct name)
>
> My question: is'nt it possible receiving events without creating a port.

Sorry, but the MIDI router code must know a destination which is given
exactly a client+port address. This is concept of the ALSA's sequencer
code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
