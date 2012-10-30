From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: possibly memory leak in alsa-lib
Date: Tue, 30 Oct 2012 11:48:35 +0100
Message-ID: <20121030114835.5cb85160@t510.perex-int.cz>
References: <508EFF67.6020901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BE56C264F21
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 11:48:36 +0100 (CET)
In-Reply-To: <508EFF67.6020901@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ivan Sorokin <vanyacpp@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Oct 2012 02:12:55 +0400
Ivan Sorokin <vanyacpp@gmail.com> wrote:

> The following program shows a few leaks in valgrind (ubuntu 12.04, 
> alsa-lib 1.0.25, eglibc 2.15):
> 
> #include <alsa/asoundlib.h>
> 
> int main()
> {
>      snd_pcm_t* pcm = 0;
>      snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0);
>      snd_pcm_close(pcm);
>      snd_config_update_free_global();
> }
> 
> Do I close pcm correctly? In file MEMORY-LEAK it is written that program 
> should call snd_config_update_free_global() to free global configuration 
> cache and I do so.
> 
> I'm not sure, but probably some leaks are caused by glibc.

Most of them are glibc leaks, but I found a little issue in alsa-lib,
too. This commit should fix it:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=edcd677bf2065c560ef578940bab8f0aacddf0e6

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
