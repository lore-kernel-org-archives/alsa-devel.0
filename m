From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: .asoundrc - share device
Date: Thu, 28 Feb 2002 15:56:11 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202281544350.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020228112349.8615D2760@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Feb 2002, Patrick Shirkey wrote:

> I attempted to get the share device working a little while ago but had
> no luck. I can try again though. Actually, at the time Abramo said that
> it was possible but that it had not been coded completely yet due to
> funding constraints. Is that right or was it not specific to the share
> device?

It's good to note that the current pcm_share plugin that exists does not
allow mixing audio from multiple source channels to one output channel.  
Instead it can be used to allow multiple clients to access different
channels of one PCM device at the same time.

For instance you could have share1, which outputs to hw:0 channels 1 and 
2, and share2 which outputs to hw:0 channels 3 and 4.

What is missing is a pcm_mix plugin, which allows multiple clients to 
write to the same channels (like esd, arts and other audio daemons).

Another currently available option is to use the pcm_shm plugin which
outputs audio to a separate aserver process (see alsa-lib/aserver). This
plugin does work, but like pcm_share, hasn't been widely used yet. But
it's the only working ALSA alternative for concurrent pcm access at the
moment.

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
