From: tom burkart <alsa@aussec.com>
Subject: Re: 0.9.3c build failure + partial patch
Date: Mon, 26 May 2003 13:54:01 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305261351280.1338-100000@home.aussec.com>
References: <s5haddeq7ow.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5haddeq7ow.wl@alsa2.suse.de>
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

On May 23, Takashi Iwai wrote:

> > Hunk 2 fixes a dependency that appears to be no longer required.
> the file is still required if you use a kernel with MODVERSIONS.
It is not created and the only place it is used is here...

> > Hunk 3 is a partial fix to the pnp.c file in support/pnp not being built.
> > It is a partial fix as it still does not get compiled at all, even though
> > issuing a make will compile it...
> this is strange.  the current version works for me.
Basically the install complains about a missing file which is not there
because it does not seem to get compiled.

tom.



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
