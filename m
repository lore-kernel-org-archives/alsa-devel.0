From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack plugin attempt
Date: Tue, 11 Feb 2003 18:36:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030211183624.31306337.mdeboer@iua.upf.es>
References: <20030210180156.438c4321.mdeboer@iua.upf.es>
	<Pine.LNX.4.44.0302102017260.2505-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302102017260.2505-100000@pnote.perex-int.cz>
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

> [...]
> Nope. The snd_pcm_mmap_appl_forward(pcm, size) is the appropriate.
> [...]
> I think that it should be opposite:
> 
> appl_ptr should be increased when application writes samples (commit) and
> hw_ptr should be increased when jack callback processes samples

Okay, your mail made everything fall into place in my mind :-)

I now have pmc->jack playback working nicely! Tomorrow I will do capture,
which should be a piece of cake. 

One question. For testing I use aplay, which now uses almost 100% cpu. Adding
a usleep in snd_pcm_jack_delay solves that problem, but I am sure it is not
the right way. How should I do it?

If I send you my code - once I have capture working - could you have a look at
it?

Thanks,

Maarten




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
