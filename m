From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: snd_pcm_mmap_playback_avail & Co. still buggy.
Date: Thu, 18 Jul 2002 15:16:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0207181218000.27937-100000@mailserver.intern.bfad.de>
References: <s5hbs958obd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs958obd.wl@alsa2.suse.de>
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


I have just downloaded alsa-lib 0.9.0rc2
alsa-lib-0.9.0rc2/src/pcm/pcm_local.h

The code below will return negative value when avail < - pcm->boundary
It may happen if appl.ptr==0 and hw.ptr+pcm->buffer_size goes from 0x7fffffff
to 0x80000000 .

static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
{
        snd_pcm_sframes_t avail;
        avail = *pcm->hw.ptr + pcm->buffer_size - *pcm->appl.ptr;
        if (avail < 0)
                avail += pcm->boundary;
        else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
                avail -= pcm->boundary;
        return avail;
}

May be the following code would be better?

static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
{
        snd_pcm_sframes_t avail;
        avail = *pcm->hw.ptr + pcm->buffer_size - *pcm->appl.ptr;
        if (avail < 0)
                avail += pcm->boundary;
	if (avail < 0)
		avail += pcm->boundary;
        else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
                avail -= pcm->boundary;
        return avail;
}

The solution is not as simple as I thought. There has to be a discontinuity
somewhere.

I have the following questions about the design:

1. Is hw.ptr allowed to be set by the alsa-driver >= than
boundary?

2. Is snd_pcm_mmap_playback_avail allowed to return negative number?

What is confusing is that there seems to be a protection against returning
negative values, but it does not work 100 %.

There are more functions nearby which have the same problem.

What I need is just an ((unsigned)hw.ptr)%boundary

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
