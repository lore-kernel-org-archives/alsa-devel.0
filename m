From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: another problems with signed arithmetic snd_pcm_mmap_playback_avail
Date: Wed, 10 Jul 2002 15:21:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0207101449480.20469-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.33.0207101418080.504-100000@pnote>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0207101418080.504-100000@pnote>
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

> You cannot use unsigned values, because we need to sum samples (it means: 
> add positive and substract negative ones). If we are in positive range, we 
> can only add samples, so the final sum result is wrong.

Since the bug database at sourceforge seems to be completely forgotten I am
reposting it here: 
http://sourceforge.net/tracker/?func=detail&aid=576153&group_id=27464&atid=390601

snd_pcm_mmap_*_avail may return negative value on some 
occasions. CONSIDER: 

 buffer_size=80 (0x50), then boundary=0x50000000 
 let *appl.ptr= 0 and *hw.ptr=0x80000051 

      avail = *pcm->hw.ptr + pcm->buffer_size - 
          *pcm->appl.ptr; 
      // 0x80000001 == - 0x7FFFFFFF 
      if (avail < 0) 
          avail += pcm->boundary; 
      else if ((snd_pcm_uframes_t) avail >= pcm->boundary) 
          avail -= pcm->boundary; 
      // here avail == 0xD0000001 == -0x2FFFFFFF 

This is not theoretical case. My application playing at 
8 kHz crashes after 3 days (0x10000000/1000 seconds) 

Q: should the driver guarantee hw.ptr < boundary ???

I am keeping *appl.ptr at 0 and using 
snd_pcm_mmap_*_avail to give me the position to write 
into mmaped buffer. I am mixing streams directly in the 
buffer, and do not care if some streams do not come. 

These functions should simply return 
((unsigned long)avail) % boundary 
instead of that funny += -= cases. 

And why there is no function which just simply returns 
the value of 
((unsigned long)*pcm->hw.ptr)% boundary 
that is all what I need. 

I have to use at the moment: 

static inline int snd_pcm_gethwpos(snd_pcm_t *pcm) { 
    snd_pcm_sframes_t ret = snd_pcm_avail_update(pcm); 
    ret += snd_pcm_commited; 
    if(ret<0) { 
    	ret = ((unsigned long) 
       	ret)%buffer_size; 
    } 
    return snd_pcm_avail_update(pcm)%buffer_size; 
} 

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Two, two, TWO treats in one.
http://thinkgeek.com/sf
