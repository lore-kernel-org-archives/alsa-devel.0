From: tom burkart <alsa@aussec.com>
Subject: Re: 0.9.3c build failure + partial patch
Date: Wed, 28 May 2003 10:13:13 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305281007180.1139-100000@home.aussec.com>
References: <s5hr86kpkrm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr86kpkrm.wl@alsa2.suse.de>
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

> hmm, then how can you check which directory to be installed?
> each distribution has different file location (although LSB exists).
> creating the file always is not preferred way in the case of init
> script.
This is correct.  That is why make install checks which one of the
various directories actually exists and then does the appropriate install
in DESTDIR/whatever, which is the correct way of doing it.  All I was
adding was for install to actually create the directories in case they did
not exist (for the case of package creation installs).

> perhaps it's better not to install it as default but via
> "make install-debian" or something like that.
This is more painful, I would have thought.

Basically, I am suggesting to leave the install alone as it is correct, I
am only adding the option of creating the directories if they don't
already exist.

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
