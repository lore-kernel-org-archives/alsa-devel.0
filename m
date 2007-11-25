From: Lennart Poettering <mznyfn@0pointer.de>
Subject: ALSA Leaking memory
Date: Sun, 25 Nov 2007 22:41:11 +0100
Message-ID: <20071125214111.GA20742@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F5E624617
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:41:12 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

Apparently alsa-libs .15 is leaking memory when using snd_pcm_open()
on some devices that cannot be opened. 

On my USB wecam which has only a single mono audio stream, opening it
as "front:3" (which of course fails) leaks a bit of memory. Consider this example:

<snip>
#include <asoundlib.h>
#include <assert.h>

int main(int argc, char *argv[]) {
    snd_pcm_t *pcm;

    if (snd_pcm_open(&pcm, "front:3", SND_PCM_STREAM_CAPTURE,
    SND_PCM_NONBLOCK) == 0) {
        int r = snd_pcm_close(pcm);
        assert(r == 0);
    }

    snd_config_update_free_global();
    return 0;
}
</snip>

And there they are gone, the 10 bytes of memory. Here's a snippet from valgrinding this program:

==22198== 10 bytes in 1 blocks are definitely lost in loss record 1 of 3
==22198==    at 0x4023765: malloc (vg_replace_malloc.c:149)
==22198==    by 0x417C44F: strdup (strdup.c:43)
==22198==    by 0x4071954: snd_determine_driver (in /usr/lib/libasound.so.2.0.0)
==22198==    by 0x406E80C: snd_config_hook_load_for_all_cards (in /usr/lib/libasound.so.2.0.0)
==22198==    by 0x406EC7C: (within /usr/lib/libasound.so.2.0.0) 
==22198==    by 0x406F896: snd_config_searcha_hooks (in /usr/lib/libasound.so.2.0.0)
==22198==    by 0x406FA74: snd_config_search_alias_hooks (in /usr/lib/libasound.so.2.0.0)
==22198==    by 0x406FCD9: snd_config_search_definition (in /usr/lib/libasound.so.2.0.0)
==22198==    by 0x40952FE: (within /usr/lib/libasound.so.2.0.0)
==22198==    by 0x80484D7: main (in /home/lennart/alsa-test)

And there seem to be more. When PulseAudio starts up it probes for
available audio devices. On my machine there are 5 sound cards, which are
all probed with device strings like "surround51:0" and so on, and in
the end some memory with a caller history like the one shown above is
shown, and another one:

==22229== 235 (180 direct, 55 indirect) bytes in 5 blocks are definitely lost in loss record 6 of 6
==22229==    at 0x4023AA4: calloc (vg_replace_malloc.c:279)
==22229==    by 0x46967B8: (within /usr/lib/libasound.so.2.0.0)
==22229==    by 0x4696C48: snd_config_make (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x4696CD0: snd_config_imake_pointer (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46EA573: _snd_pcm_hook_ctl_elems_install (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46EAC10: (within /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46EB2BC: _snd_pcm_hooks_open (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46C0CD4: (within /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46C1467: snd_pcm_open_slave (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46D232B: _snd_pcm_route_open (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46C0CD4: (within /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46C1467: snd_pcm_open_slave (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46E47CC: _snd_pcm_empty_open (in /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46C0CD4: (within /usr/lib/libasound.so.2.0.0)
==22229==    by 0x46C13D2: (within /usr/lib/libasound.so.2.0.0)
==22229==    by 0x412E007: pa_alsa_open_by_device_id (alsa-util.c:529)
==22229==    by 0x4135904: module_alsa_sink_LTX_pa__init (module-alsa-sink.c:781)
==22229==    by 0x419CD2B: pa_module_load (module.c:115)
==22229==    by 0x4164D33: hal_device_load_alsa (module-hal-detect.c:204)
==22229==    by 0x4165313: hal_device_add (module-hal-detect.c:323)
 
Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
