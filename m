From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm_jack plugin attempt
Date: Thu, 13 Feb 2003 21:26:04 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302132124320.1315-100000@pnote.perex-int.cz>
References: <20030213183957.71fa1698.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030213183957.71fa1698.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Feb 2003, Maarten de Boer wrote:

> Attached you find the patch with my latest changes. Both playback and
> capture from jack work now, though not simultanously.
> 
> $ jackd -d alsa -p 4096 -d hw:0
> 
> $ aplay -Dmyplug /usr/share/sounds/KDE_Startup.wav
> 
> $ arecord -Dmyplug -d 4 foo.wav
> 
> (see my previous mail on how to define myplug)
> 
> Now, my next problem is linked playback/capture
> 
> $ ./latency -m 4096 -M 4096 t 1 -p -e -C myplug -P myplug
> [...]
> ALSA lib pcm.c:1127:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed: Bad address
> Streams link error: Bad address
> 
> Suggestions?

The snd_pcm_link() uses special ioctl() directly and only the ALSA driver
knows it. I'll try to fix this problem when I'll get some time, because
also the dmix plugin needs this fix.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
