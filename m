From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 19:52:46 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305211934470.19955-100000@ecabase.localdomain>
References: <20030521115921.B793@loki.cs.umass.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030521115921.B793@loki.cs.umass.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Cochran <cochran@cs.umass.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2003, Richard Cochran wrote:

> Unfair, perhaps, yet true. Getting alsa to work with a 2.4.x kernel
> today is not exactly easy.

It's not that hard either, but yes, it could be easier.
But this is true for practically all kernel subsystems
that are not yet part of the standard kernel. And for 
a reason. ALSA developers cannot change how the Linux 
kernel development works.

> I don't know what "plug_hw" is or what it provides. I would _love_ to
> read about it. I would like to know what is impossible with OSS that
> is easy with Alsa, specifically.

We'd all love to, but someone has to write it. If you can't
live without better documentation, and don't want or cannot
help, then I guess you just have to come back later when
it's ready. I'd say once ALSA is bundled by all the major
distros (some of them already do), we'll see more documentation.

This is just the same with all kernel subsystems. Very few kernel
subsystems (or specific features/modules) have very detailed architecture
descriptions available, although most of them have some docs (usually at
least a HOWTO). Even fewer have these docs _before_ they are included to
stable kernel.

Comparing to OSS is not entirely fair, as the architecture
document you are talking about documents the commercial 
OSS API, not the OSS/kernel API. It's mostly the same, but
not all OSS kernel drivers behave as the commercial OSS 
drivers, so it's not really the same (for instance the
everlasting problem with different ways to implement full-duplex).

> Mixing can be done using a fifo. It would not be hard to shadow the

Simply does not work nor scale if you want low latency and support
multichannel configurations. See the numerous discussions during the last
four to five years here, linux-audio-dev and other related mailing lists.
For real solutions, see ALSA's dmix feature (check mailing list arhives)
and/or JACK (http://jackit.sf.net).


-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
