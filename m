From: Arcady Genkin <agenkin-lst-alsa-devel@thpoon.com>
Subject: Re: Re: Audigy 2 support - update
Date: Sat, 24 May 2003 22:13:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <863cj3vkmj.fsf@tea.thpoon.com>
References: <20030523051240.GA10831@www.angiotech.com>
	<1053675028.18540.70.camel@rivendell.home.local>
	<yw1xznlevz8l.fsf@zaphod.guide>
	<1053747556.6906.4.camel@rivendell.home.local>
	<20030524165935.GB17884@www.angiotech.com>
	<86el2ouqq4.fsf@tea.thpoon.com>
	<3ECFD2BC.1000307@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ECFD2BC.1000307@superbug.demon.co.uk> (James
	Courtier-Dutton's message of "Sat, 24 May 2003 21:14:52 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton <James@superbug.demon.co.uk> writes:

> As you can see, 0x1102, 0x0002 is my SB Live.
> Add a extra line for your Audigy 2 platinum ex.
>
> and recompile, and see if that helps.

It seems that there already is a line for my card:

,----[ lspci output ]
| 02:05.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
| 02:05.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
| 02:05.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
`----

,----[ lspci -r output ]
| 02:05.0 Class 0401: 1102:0004 (rev 04)
| 02:05.1 Class 0980: 1102:7003 (rev 04)
| 02:05.2 Class 0c00: 1102:4001 (rev 04)
`----

So, according to your instructions, my card should be identified by
"Class 0401: 1102:0004", but there already is a line for that in
alsa-kernel/pci/emu10k1/emu10k1.c:

{ 0x1102, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },    /* Audigy */

Am I missing something?  Thanks a lot for your reply!
-- 
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
