From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: another problems with signed arithmetic
 snd_pcm_mmap_playback_avail
Date: Wed, 10 Jul 2002 18:32:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0207101828240.20469-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.21.0207101449480.20469-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0207101449480.20469-100000@mailserver.intern.bfad.de>
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

> I have to use at the moment: 
> 
> static inline int snd_pcm_gethwpos(snd_pcm_t *pcm) { 
>     snd_pcm_sframes_t ret = snd_pcm_avail_update(pcm); 
>     ret += snd_pcm_commited; 
>     if(ret<0) { 
>     	ret = ((unsigned long) 
>        	ret)%buffer_size; 
>     } 
>     return snd_pcm_avail_update(pcm)%buffer_size; 

BUG. I should have used:

	return ret;

But anyway, what do you think about snd_pcm_avail_update returning negative
values?

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Two, two, TWO treats in one.
http://thinkgeek.com/sf
