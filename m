From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: poll() and select()
Date: Tue, 14 Oct 2003 19:41:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031014194105.469f8da7.rpav@mephle.com>
References: <20031013105324.637917b0.rpav@mephle.com>
	<s5h4qycup1q.wl@alsa2.suse.de>
	<20031014113031.7fde9794.rpav@mephle.com>
	<20031015010559.GA15113@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031015010559.GA15113@dbz.icequake.net>
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

On Tue, 14 Oct 2003 20:06:00 -0500
Ryan Underwood <nemesis-lists@icequake.net> wrote:

> Silly question, but is 'npfd' the file descriptor you are polling + 1?

I AM DUMB.

I totally overlooked this.  Simple fix, and it works great.
Thanks. :-)  You'd think I had never done this before.

So the select() version works fine, with the bridge from the poll()
file structure.  This should integrate with ruby just fine then.

thanks,

-- 
Ryan Pavlik <rpav@mephle.com>

"I'll *prove* to you that sword-chucks are the
 single greatest advancement in all weaponology." - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
