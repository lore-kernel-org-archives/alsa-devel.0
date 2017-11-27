From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ["PATCH alsa-lib"] Change snd_dlopen() function to
 return the error string
Date: Tue, 28 Nov 2017 03:19:51 +0900
Message-ID: <511ce0ed-77e2-b319-e1a1-e461ba1ac1e1@sakamocchi.jp>
References: <20171127085016.11339-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 827E6266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:19:53 +0100 (CET)
In-Reply-To: <20171127085016.11339-1-perex@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

On Nov 27 2017 17:50, Jaroslav Kysela wrote:
> The dlopen() function might fail also for another reason than
> a missing file, thus return the error string from dlerror().
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> ---
>   include/global.h        |  2 +-
>   src/Versions.in         |  5 +++++
>   src/conf.c              | 13 ++++++-----
>   src/dlmisc.c            | 60 +++++++++++++++++++++++++++++++++++++++----------
>   src/hwdep/hwdep.c       |  6 ++---
>   src/mixer/simple_abst.c | 10 ++++-----
>   src/pcm/pcm_hooks.c     |  8 +++----
>   src/pcm/pcm_meter.c     |  6 ++---
>   src/rawmidi/rawmidi.c   |  6 ++---
>   src/seq/seq.c           |  6 ++---
>   src/timer/timer.c       |  6 ++---
>   src/timer/timer_query.c |  6 ++---
>   12 files changed, 88 insertions(+), 46 deletions(-)

Unfortunately, this patch brings build error in my environment (Ubuntu 
17.10 amd64, gcc7.2.0 from gcc-7 7.2.0-8ubuntu3).

$ ./gitcompile
$ make
make[2]: Entering directory '/tmp/alsa-lib/src'
   CCLD     libasound.la
/usr/bin/ld: unable to find version dependency `ALSA_1.1.6'
pcm/.libs/libpcm.a(pcm_generic.o): In function `snd1_pcm_generic_hwsync':
/tmp/alsa-lib/src/pcm/pcm_generic.c:142: warning:
collect2: error: ld returned 1 exit status
Makefile:491: recipe for target 'libasound.la' failed
make[2]: *** [libasound.la] Error 1

At present, I don't know exactly the reason, but I'll start 
investigating it in next morning (I'd like to have sleep...).

I found some nitpicking.

1. 'modules/mixer/simple/sbasedl.c' calls this function but missing 
changes in this patch.

(As I suggested to you in a previous Audiominiconf, it's good to us to 
investigate simplification of the unused abstraction of 'simple' mixer 
functionality.)

2. A line includes a tab only.

> diff --git a/src/dlmisc.c b/src/dlmisc.c
> index f154ebd0..fca843e1 100644
> --- a/src/dlmisc.c
> +++ b/src/dlmisc.c
> @@ -73,24 +79,49 @@ void *snd_dlopen(const char *name, int mode)
> ...
> +errpath:
> +	if (errbuf)
> +		snprintf(errbuf, errbuflen, "%s: %s", filename, dlerror());
> +	return NULL;
> +	
>   #else
>   	return NULL;
>   #endif
>   }


Regards

Takashi Sakamoto
