From: tom burkart <alsa@aussec.com>
Subject: Re: 0.9.3c build failure + partial patch
Date: Wed, 28 May 2003 11:48:51 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305281141590.1139-100000@home.aussec.com>
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
Correct.  The existing checks are fine as they check /etc/... for the most
common distributions and so it installs it in the correct place.  What I
am adding is that install checks whether the destination directory exists
and creates it if it doesn't.  If the "if" statement evaluates to true
then the directory exists and is the correct one.  If you have a $DESTDIR
set, the actual installation dir will most likely not exist and install
fails.  Hence the reason for getting install to check that the directories
are there and to install them as required.

> perhaps it's better not to install it as default but via
> "make install-debian" or something like that.
Absolutely not necessary as the existing code is nearly correct.

tom.



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
