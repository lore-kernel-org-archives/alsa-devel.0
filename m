From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA Leaking memory
Date: Sun, 25 Nov 2007 22:56:41 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711252254250.7688@tm8103.perex-int.cz>
References: <20071125214111.GA20742@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 674C724611
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:56:42 +0100 (CET)
In-Reply-To: <20071125214111.GA20742@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 25 Nov 2007, Lennart Poettering wrote:

> Hi!
> 
> Apparently alsa-libs .15 is leaking memory when using snd_pcm_open()
> on some devices that cannot be opened. 
> 
> On my USB wecam which has only a single mono audio stream, opening it
> as "front:3" (which of course fails) leaks a bit of memory. Consider this example:
> 
> <snip>
> #include <asoundlib.h>
> #include <assert.h>
> 
> int main(int argc, char *argv[]) {
>     snd_pcm_t *pcm;
> 
>     if (snd_pcm_open(&pcm, "front:3", SND_PCM_STREAM_CAPTURE,
>     SND_PCM_NONBLOCK) == 0) {
>         int r = snd_pcm_close(pcm);
>         assert(r == 0);
>     }
> 
>     snd_config_update_free_global();
>     return 0;
> }
> </snip>
> 
> And there they are gone, the 10 bytes of memory. Here's a snippet from valgrinding this program:
> 
> ==22198== 10 bytes in 1 blocks are definitely lost in loss record 1 of 3
> ==22198==    at 0x4023765: malloc (vg_replace_malloc.c:149)
> ==22198==    by 0x417C44F: strdup (strdup.c:43)
> ==22198==    by 0x4071954: snd_determine_driver (in /usr/lib/libasound.so.2.0.0)
> ==22198==    by 0x406E80C: snd_config_hook_load_for_all_cards (in /usr/lib/libasound.so.2.0.0)
> ==22198==    by 0x406EC7C: (within /usr/lib/libasound.so.2.0.0) 
> ==22198==    by 0x406F896: snd_config_searcha_hooks (in /usr/lib/libasound.so.2.0.0)
> ==22198==    by 0x406FA74: snd_config_search_alias_hooks (in /usr/lib/libasound.so.2.0.0)
> ==22198==    by 0x406FCD9: snd_config_search_definition (in /usr/lib/libasound.so.2.0.0)
> ==22198==    by 0x40952FE: (within /usr/lib/libasound.so.2.0.0)
> ==22198==    by 0x80484D7: main (in /home/lennart/alsa-test)

Broken valgrind? I cannot reproduce here and from first glance, the error 
path in snd_config_hook_load_for_all_cards is good.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
