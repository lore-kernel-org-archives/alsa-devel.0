From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack plugin attempt
Date: Thu, 13 Feb 2003 17:12:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030213171211.673728b8.mdeboer@iua.upf.es>
References: <20030212185838.15069c79.mdeboer@iua.upf.es>
	<Pine.LNX.4.44.0302122157410.30420-100000@pnote.perex-int.cz>
	<20030213135317.3ab66d5b.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030213135317.3ab66d5b.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

I wrote:


> The problem I described in my previous mail (no more calls to 
> snd_pcm_jack_mmap_commit after start) still occurs though... Any
> idea what might be the problem, or where to look?

Okay, I fixed this. It was a missing

	pcm->poll_events = POLLIN;

(after pcm->poll_fd = fd[1] , in snd_pcm_jack_open)

Can you fix this in CVS?

Playback now works nicely, including the polling. Going to add capture now.

Maarten


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
