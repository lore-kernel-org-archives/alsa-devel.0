From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rawmidi bug or missed feature?
Date: Sat, 2 Mar 2002 11:28:49 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203021126500.681-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3C7EB5A2.335E82C4@ufh.se>
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

On Thu, 28 Feb 2002, Peter Enderborg wrote:

> I have a program that read's from a raw midi device. In midi there are
> some simple compression. It is assumed that if the data flow is correct,
> and the data should be interpreted as paramaters to previus command if
> it's not a new command. But when I open a raw midi stream I can get in
> to the stream without having the "previus" command. Is there any way to
> do a query or reset the stream so I can get that command? If it's only
> one midi channel sending the same type of command it will never get in
> to sync!

RawMidi devices don't interpret MIDI data in any way. So, you get exactly 
what's on input. Or are you refering virmidi devices?

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
