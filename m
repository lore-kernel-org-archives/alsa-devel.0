From: Ken McMillan <mcmillan@cadence.com>
Subject: Problems with ALSA and plugins
Date: Sun, 24 Mar 2002 18:55:53 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203241826310.9245-100000@mcmillan.cadence.com>
References: <Pine.LNX.4.33.0203220915160.711-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0203220915160.711-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I was having some trouble using the ALSA library called from within a
plugin. Apparently at some point libasound dlsym's itself, using a
null handle, which doesn't work if libasound is loaded as a dependency
of a dlopen'ed library (since its symbols are then not available to link
libraries against).

A web search produced an earlier post to this list (sorry, I lost the
reference) in which Jaroslav suggests opening the plugin library using
the RTLD_GLOBAL flag. I tried this, and in fact it works, but there is
a problem if you are loading more than one plugin at a time. That is,
with the plugins loaded RTLD_GLOBAL, there may be conflicts between
symbols in the plugins or their dependencies, leading to very puzzling
results (i.e., the wrong function being called). This actually
happened to me and it took a while to figure out what was going wrong.

In general, I don't think it's a good idea to have applications
loading plugins with RTLD_GLOBAL, since the application writer has no
idea what libraries might be loaded with the plugins (and thus what
symbols might be added to the symbol table). It occurred to me that I
could just have the plugin itself dlopen libasound with RTLD_GLOBAL in
its _init routine, which would then make the libasound symbols
available to itself (!). However, besides this being a nasty hack, this
still leaves the problem that the libasound symbols are made global.

On the whole, if it's not a terrible performance hit, it might be
better to have libasound dlopen itself in order to lookup symbols,
rather than using a null handle. This seems easier and cleaner than
documenting the problem so that application writers can work around it.

Just a suggestion.

	Best regards -- Ken McMillan
