From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack plugin attempt
Date: Thu, 13 Feb 2003 13:53:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030213135317.3ab66d5b.mdeboer@iua.upf.es>
References: <20030212185838.15069c79.mdeboer@iua.upf.es>
	<Pine.LNX.4.44.0302122157410.30420-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302122157410.30420-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I've updated a bit your code, but I cannot test it myself, because I 
> cannot connect to a jack port - invalid destination port name - (I'll 
> look what's wrong tomorrow).

Thanks a lot for your updates.

The problem I described in my previous mail (no more calls to 
snd_pcm_jack_mmap_commit after start) still occurs though... Any
idea what might be the problem, or where to look?

> > [snip about polls]
> Yes, it should work, but I've added missing poll_revents callback 
> initialization.

Ok.

> I've commited your code to CVS so we can share it.

Great, thanks.

Maarten


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
