From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Receiving Sequencer Events
Date: Sun, 17 Feb 2002 15:51:35 +0100 (MET)
Message-ID: <XFMail.020217155135.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <NGBBLNODKDFPBFMBBFAFIEPJCAAA.James@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo List,

I want to receive midi events from my external midi keyboard.

Therefore I tried the seq decoder which comes with the alsa package.
This application creates a port and when I connect the midi port to this
listener ports, i can see the events coming from the keyboard.

That means, If i want to receive events, i have to create a port and connect it
to the source port(external midi "port") - then receive the events with

snd_seq_input_event (not sure whether this is the correct name)

My question: is'nt it possible receiving events without creating a port.

For sure snd_seq_input_event cannot know where to get the events from, but how
can i tell snd_seq_input_event ???

rds guenther


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
