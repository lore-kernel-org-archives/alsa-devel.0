From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: EWX 24/96 and SPDIF: solved? (with patch)
Date: Wed, 1 Oct 2003 00:31:22 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310010028500.853-100000@ecabase.localdomain>
References: <Pine.OSF.4.58.0309302201580.257614@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.58.0309302201580.257614@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: Denis Sbragion <d.sbragion@infotecna.it>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Sep 2003, Tommi Sakari Uimonen wrote:

> This, I think, caused also ecasound problems; it couldn't stop the
> recording and after killing the process I found out that it had not
> recorded anything even thougn the engine started fine.
> I quess the drivers were halted just after ecasound engine started,
> otherwise it might have reported some errors.

Ecasound does write all data in the buffers to files upon exit, so most 
it is likely that the audio device has not delivered any data. But, but, 
bugs are always a possibility. You could try running with "-z:nodb" (only
when testing though) and see whether the behaviour is the same.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
