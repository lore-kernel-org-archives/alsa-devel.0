From: Justin Cormack <justin@street-vision.com>
Subject: Re: arecord to support >2GB files?
Date: 27 Aug 2003 12:07:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1061982466.30543.64.camel@lotte.street-vision.com>
References: <Pine.OSF.4.56.0308271045210.398158@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.56.0308271045210.398158@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-08-27 at 09:15, Tommi Sakari Uimonen wrote:
> I'm planning to use arecord for serious harddisk recording, but it can't
> write files bigger than 2BG. After browsing through kernel mailing lists
> about LFS I concluded that the problem is arecord, not the underlying
> filesystem (and since I've had >8GB files on it :).
> 
> I looked at the code, but didn't have any idea what to change.

You can almost certainly just add
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
to the CFLAGS in the Makefile. (it would be good if this was default on
32bit platforms).

Or just make it output to stdout and then redirect it to a file.

Justin




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
