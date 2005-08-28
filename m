From: Jhair Tocancipa Triana <jhair_tocancipa@gmx.net>
Subject: mmap as parameter for ALSA kernel modules
Date: Sun, 28 Aug 2005 11:00:47 +0200
Message-ID: <87zmr25tc0.fsf@mandala.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

When running mplayer or realplayer inside a 32bit chrooted environment
on a 64bit machine, I've the problem the sound "jumps". mplayer logs
the following

alsa-space: xrun of at least 2.357 msecs. resetting stream?,?% 0 0 93%
alsa-space: xrun of at least 63.491 msecs. resetting stream,?% 1 0 91%

while having this behaviour. I'm using kernel 2.6.12.5.

I've fixed this running mplayer with the -ao alsa:mmap parameter. With
this sound playback is smooth again.

Now I want that ALSA uses mmap per default. In my case, Realplayer
playback has same problem as mplayer had (sound "jumps") but
Realplayer doesn't have an option to set ALSA parameters.

So my question is: Does exist an ALSA kernel module parameter to
toggle use of mmap and if yes to which ALSA kernel module should this
parameter be passed to?

BTW, mplayer does the following with -ao alsa:mmap parameter:

/* mplayer/libao2/ao_alsa.c */

      if (ao_mmap) {
	snd_pcm_access_mask_t *mask = alloca(snd_pcm_access_mask_sizeof());
	snd_pcm_access_mask_none(mask);
	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_COMPLEX);
	err = snd_pcm_hw_params_set_access_mask(alsa_handler, alsa_hwparams, mask);
	mp_msg(MSGT_AO,MSGL_INFO,"alsa-init: mmap set\n");
      }

Thanks in advance,

-- 
--
--Jhair



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
