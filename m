From: tom burkart <alsa@aussec.com>
Subject: Re: 0.9.3c build failure + partial patch
Date: Wed, 28 May 2003 12:20:33 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305281217560.1139-100000@home.aussec.com>
References: <s5hptm4pkmt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptm4pkmt.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On May 27, Takashi Iwai wrote:

> ?? i see the file in fact.
> then this might be the problem of make.
> the older make cannot build some modules correctly.
Ok, the problem is that "make all" (or just "make") is not a build
prerequisite to make install.

This obsoletes hunk 2 and 3 of my patch.  Please discard.

tom.
Consultant

AUSSEC    Phone: 61 4 1768 2202
339 Blaxland Rd., Ryde NSW 2112
Email: tom@aussec.com



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
