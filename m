From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 16:27:39 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308271555510.9988-100000@ecabase.localdomain>
References: <Pine.OSF.4.56.0308271548370.398158@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.56.0308271548370.398158@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Aug 2003, Tommi Sakari Uimonen wrote:

>> Ecasound has support for LFS (compile with --with-largefile).
> Is there also --with-96khz option? :)
> If there is, or there will be soon (in two days), I'll change to that.

No need for a separate option :) ...
ecasound -f:s32_le,2,96000 -i alsa,default -o foo.wav

> And about GUI's for ecasound, are there such that won't affect the
> recording - I mean that the recording would be as "xrun free" as running
> ecasound in console?

The Ecasound engine is isolated from the control engine, so the GUIs
cannot interfere with the audio recording process.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
