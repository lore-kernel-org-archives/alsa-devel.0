From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-plugins-1.17] Regression in JACK plugin
Date: Tue, 23 Oct 2018 16:43:48 +0200
Message-ID: <ffc0874e-79c9-2d65-8cd9-a93ca8fa2381@perex.cz>
References: <be1e30c7b7f493d0235a135964a9a9d3@teknik.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 95B612675C3
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 16:43:50 +0200 (CEST)
In-Reply-To: <be1e30c7b7f493d0235a135964a9a9d3@teknik.io>
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
To: tet <teteros@teknik.io>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 23.10.2018 v 15:19 tet napsal(a):
> Hi, after updating to alsa-plugins-1.17 ALSA throws:
> "ALSA lib pcm_plug.c:1273:(_snd_pcm_plug_open) Unknown field playback_ports

The line number does not match to the latest sources:

https://github.com/alsa-project/alsa-lib/blob/master/src/pcm/pcm_plug.c#L1286

What is version of your alsa library?

					Jaroslav

> 
> My ~/.asourdrc is working in 1.16 and it does not look like the syntax changed for the plugin when looking at the readme.
> 
> pcm.jack {
>   type plug slave.pcm {
>     type jack
>     capture_ports {
>       0 system:capture_1
>       1 system:capture_1
>     }
>     playback_ports {
>       0 system:playback_1
>       1 system:playback_2
>     }
>   }
>   hint.description "JACK Audio Kit"
> }
> pcm.!default {
>   @func getenv
>     vars [ PCM ]
>     default jack
> }
> 
> Any ideas?
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
