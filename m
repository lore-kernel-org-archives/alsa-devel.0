From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 17:02:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111170241.2975b352.rpav@nwlink.com>
References: <20030110113711.06e8ee2d.rpav@nwlink.com>
	<Pine.LNX.4.33.0301111543330.613-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0301111543330.613-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Jan 2003 15:46:15 +0100 (CET)
Jaroslav Kysela <perex@perex.cz> wrote:

<snip>
> ALSA driver should handle this correctly (at least current CVS code).
> The write sequence is locked.

Hrm, I'll check through the code---after playing with it, it doesn't
appear things are 100% yet.  I had decent luck at first, with messages
not trampling each other, but as I added new sequences (using seq24 to
test), odd problems developed.

The first was port 1 acting like broadcast, which I haven't seen before;
this would be fixed temporarily by reloading the driver.  Then voices
started losing notes and messages, much as before.

I will look at the (new?) write locking and see if I can figure
something out.

Thanks,

-- 
Ryan Pavlik <rpav@users.sf.net>

"Nautical, schmautical. Give me one hour and I'll know
 enough to sail us into orbit!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
