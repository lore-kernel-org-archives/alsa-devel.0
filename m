From: Paul Davis <pbd@Op.Net>
Subject: Re: Rawmidi bug or missed feature?
Date: Fri, 01 Mar 2002 08:45:49 -0500
Message-ID: <200203011345.IAA12541@renoir.op.net>
In-reply-to: Your message of "Thu, 28 Feb 2002 23:56:35 +0100."
             <3C7EB5A2.335E82C4@ufh.se>
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

>I have a program that read's from a raw midi device. In midi there
>are some simple compression.  It is assumed that if the data flow is
>correct, and the data should be interpreted as paramaters to previus
>command if it's not a new command. But when I open a raw midi stream
>I can get in to the stream without having the "previus" command. Is
>there any way to do a query or reset the stream so I can get that
>command? If it's only one midi channel sending the same type of
>command it will never get in to sync!

raw MIDI means ***RAW*** MIDI. there is no parsing, no state, no
history, no automatic reset. you just read and write a stream of
bytes.

it sounds as if you should issue a full MIDI reset sequence when you
open the device (all notes off on every channel, reset all controllers
to a default value, restore all programs to a known state, etc.)

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
