From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Wed, 21 Feb 2007 13:10:48 +1100
Message-ID: <45DBAA28.7000807@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>
	<45DAEBB8.70808@usherbrooke.ca> <45DB713F.9090804@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45DB713F.9090804@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've been having some problems with my plugin and trying to debug it,
I've discovered what seems to be massive memory corruption in the rate
converter plugin layer. It's actually not just with my plugin, but also
with the libsamplerate plugin.

For example, here's some of the stuff I found when running aplay in
valgrind with the libsamplerate plugin (conversion was 4000 to 32000,
which makes problems easier to trigger):

==21452==
==21452== Conditional jump or move depends on uninitialised value(s)
==21452==    at 0x4482EF9: src_float_to_short_array (in
/usr/lib/libsamplerate.so.0.1.1)
==21452==    by 0x40EFB67: pcm_src_convert_s16 (rate_samplerate.c:126)
==21452==    by 0x4081A0D: do_convert (pcm_rate.c:523)
==21452==    by 0x4081DE9: snd_pcm_rate_commit_area (pcm_rate.c:541)
==21452==    by 0x4081EDA: snd_pcm_rate_sync_playback_area (pcm_rate.c:862)
==21452==    by 0x4081F86: snd_pcm_rate_mmap_commit (pcm_rate.c:1012)
==21452==    by 0x406A529: snd_pcm_mmap_commit (pcm.c:6312)
==21452==    by 0x4075779: snd_pcm_mmap_write_areas (pcm_mmap.c:123)
==21452==    by 0x406A325: snd_pcm_write_areas (pcm.c:6499)
==21452==    by 0x4074803: snd_pcm_mmap_writei (pcm_mmap.c:186)
==21452==    by 0x4061275: snd_pcm_writei (pcm_local.h:401)
==21452==    by 0x804C522: (within /usr/bin/aplay)
==21452==
==21452== Invalid write of size 1
==21452==    at 0x401E408: memcpy (mac_replace_strmem.c:394)
==21452==    by 0x406AE6C: snd_pcm_area_copy (pcm.c:2549)
==21452==    by 0x406B223: snd_pcm_areas_copy (pcm.c:2696)
==21452==    by 0x4081D81: snd_pcm_rate_commit_area (pcm_rate.c:834)
==21452==    by 0x408207E: snd_pcm_rate_drain (pcm_rate.c:1102)
==21452==    by 0x4060F94: snd_pcm_drain (pcm.c:1092)
==21452==    by 0x804E625: (within /usr/bin/aplay)
==21452==    by 0x80506FB: (within /usr/bin/aplay)
==21452==    by 0x4142EA1: __libc_start_main (in
/lib/tls/i686/cmov/libc-2.3.6.so)
==21452==  Address 0x42C82B8 is 0 bytes after a block of size 8,192 alloc'd
==21452==    at 0x401C422: malloc (vg_replace_malloc.c:149)
==21452==    by 0x4074DB1: snd_pcm_mmap (pcm_mmap.c:420)
==21452==    by 0x406D79B: sndrv_pcm_hw_params (pcm_params.c:2357)
==21452==    by 0x4075F7D: snd_pcm_generic_hw_params (pcm_generic.c:104)
==21452==    by 0x406BA5E: snd_pcm_hw_params_slave (pcm_params.c:2240)
==21452==    by 0x407F9DD: snd_pcm_rate_hw_params (pcm_rate.c:241)
==21452==    by 0x406D58B: sndrv_pcm_hw_params (pcm_params.c:2316)
==21452==    by 0x408605C: snd_pcm_plug_hw_params (pcm_plug.c:960)
==21452==    by 0x406D58B: sndrv_pcm_hw_params (pcm_params.c:2316)
==21452==    by 0x4060A24: snd_pcm_hw_params (pcm.c:825)
==21452==    by 0x804B286: (within /usr/bin/aplay)
==21452==    by 0x804DFE3: (within /usr/bin/aplay)

I omitted the ioctl() warnings, which are probably just due to valgrind
not knowing what ALSA's doing. In another simiar run, I got.

==21689==
==21689== Invalid free() / delete / delete[]
==21689==    at 0x401CFCF: free (vg_replace_malloc.c:235)
==21689==    by 0x448298D: src_delete (in /usr/lib/libsamplerate.so.0.1.1)
==21689==    by 0x40EF99A: pcm_src_free (rate_samplerate.c:61)
==21689==    by 0x407FDE7: snd_pcm_rate_hw_free (pcm_rate.c:338)
==21689==    by 0x40607D1: snd_pcm_hw_free (pcm.c:848)
==21689==    by 0x4084E77: snd_pcm_plug_hw_free (pcm_plug.c:976)
==21689==    by 0x40607D1: snd_pcm_hw_free (pcm.c:848)
==21689==    by 0x406A053: snd_pcm_close (pcm.c:698)
==21689==    by 0x80506C4: (within /usr/bin/aplay)
==21689==    by 0x4142EA1: __libc_start_main (in
/lib/tls/i686/cmov/libc-2.3.6.so)
==21689==  Address 0x20002 is not stack'd, malloc'd or (recently) free'd
==21689==


I get similar problems with my resampler. And even when there's no
apparent error, the playback sometimes just stops in the middle for no
reason. I don't get these kinds of problems when using the cards's
native rate or even when using crappy internal resampler. I definitely
think this needs to be fixed before we get anything halfway decent working.

	Jean-Marc

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
