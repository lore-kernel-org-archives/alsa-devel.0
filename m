From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: poll() and select()
Date: Thu, 16 Oct 2003 11:28:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031016112848.59856639.rpav@mephle.com>
References: <20031013105324.637917b0.rpav@mephle.com>
	<s5h4qycup1q.wl@alsa2.suse.de>
	<20031014113031.7fde9794.rpav@mephle.com>
	<20031015010559.GA15113@dbz.icequake.net>
	<20031014194105.469f8da7.rpav@mephle.com>
	<Pine.LNX.4.53.0310161950530.1221@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0310161950530.1221@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Oct 2003 19:54:20 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

<snip>
> Don't use select() if possible. You don't know which direction is required
> for a file descriptor. You must use snd_seq_poll_descriptors_revents()
> which mangles the used direction and reports the correct one to
> the application (and yes, it might be an opposite or both
> directions in real if we implementing some complex devices behind this
> API).
<snip>

Unfortunately it's necessary...  I'm trying to write a ruby module,
and ruby uses soft threads for portability's sake.  It's also
unfortunately not threadsafe, or I could just dump the sequencer stuff
in a pthread and go from there.

It does provide rb_thread_select(), which uses select() but schedules
its own threads while blocking.

The pollfd struct does provide the 'events' member which can have
POLLIN and/or POLLOUT, so I should still be able to put the
descriptors in the right group for select, no?

thanks,

-- 
Ryan Pavlik <rpav@mephle.com>

"Prepare to face the unparalleled force of a master
 of all twelve zodiac kenshido styles!" - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
