From: Ryan Pavlik <rpav@nwlink.com>
Subject: YES! :-) Was: Bug: ALSA Sequencer or MTPAV - easy to
 reproduce
Date: Wed, 12 Feb 2003 13:44:36 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212134436.3b9e2f10.rpav@nwlink.com>
References: <20030212123025.12b1c582.rpav@nwlink.com>
	<Pine.LNX.4.44.0302122136400.30420-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302122136400.30420-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003 21:41:50 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:


> It seems that mtpav don't remeber the old status byte for each
> channels. If it's true, then we need to take care about the expansion
> in the mtpav driver, because the sequencer MIDI driver removes
> duplicated status bytes to opmitize throughput.

Yes! this works! (Or basically the equivalent does.)  Now, from looking
at things, it seems like the MTPAV treats a device change like another
midi message... basically using 0xF5 as a midi system message to change
device.  According to the references I'm looking at, 0xF5 is left
undefined.  This means technically the mtpav isn't wrong, just
strange. ;-)

For a somewhat elegant solution, it may be possible to have the mtpav
track the last device and running status.  I initially thought this
would be impossible, but it looks like it could be done in
snd_mtpav_output_port_write() (mtpav.c:298).  I will work on this and
submit a patch shortly, unless someone suggests a better solution.

> To test this behaviour, please, try this patch:
<snip> 

Thanks :-)

-- 
Ryan Pavlik <rpav@users.sf.net>

"I distinctly remember dancing on your grave." - 8BT


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
