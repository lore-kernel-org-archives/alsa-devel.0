Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA58C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Oct 2022 14:06:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2ACA0168D;
	Wed,  5 Oct 2022 16:05:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2ACA0168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664978802;
	bh=w42Chfzp96DmQ2BROQ68wrzt8UtcXTqP184e6KPPDZs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ar0mjNBaS2P9C3KcHDqxRxnhN2ISFp+z6M9JUmpTIGMMrOi0eThn0i00cVWDGXMYn
	 aNiJqe+yGeT3h/aic2h4OjbsR3akvS8SmgHp3N6eB2w25kFN6DNIolmiiv84SRQTdg
	 kkLxt9L3zGQlYs+Xr9is+nXDbLe8Zveoipv36kdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA064F800BF;
	Wed,  5 Oct 2022 16:05:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9596CF801F7; Wed,  5 Oct 2022 16:05:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 04E14F800BF
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2022 16:05:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04E14F800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1664978747337639093-webhooks-bot@alsa-project.org>
References: <1664978747337639093-webhooks-bot@alsa-project.org>
Subject: ALSA multi plugin error when combining two soundcards
Message-Id: <20221005140550.9596CF801F7@alsa1.perex.cz>
Date: Wed,  5 Oct 2022 16:05:50 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #273 was opened from anthonio9:

My goal is to mix the output of two sound cards (RAVENNA from [bondagit](https://github.com/bondagit/aes67-linux-daemon.git) and hifiberry), then pass it to a DSP pcm plugin. As it's not possible with `dmix` (dmix only supports output to hw devices) the reasonable next step was `multi` plugin, but my tries always end up in a failure. Below is a quite standard `multi` configuration inspired by alsa docs that I'm using:

```sh
pcm.quad {
    type multi
    slaves.a.pcm "hw:RAVENNA"
    slaves.a.channels 2
    slaves.b.pcm "hw:sndrpihifiberry"
    slaves.b.channels 2

    bindings.0.slave a
    bindings.0.channel 0
    bindings.1.slave a
    bindings.1.channel 1
    bindings.2.slave b
    bindings.2.channel 0
    bindings.3.slave b
    bindings.3.channel 1
    master 1
}

pcm.quad2 {
    type plug
    slave.pcm "quad"
}
```

This is run with `alsaloop` to be input into an extplug plugin that easily accepts 4 channels of audio - `alsadsp`:
```sh
$ alsaloop -C quad -P alsadsp -c 4
Rate 48000Hz not available for capture quad: Invalid argument
Unable to set parameters for capture quad stream: Invalid argument
Loopback start failure.
```
This results in a failure, moreover running `quad2` also results in the same type of error.

Next step was to try plug pcm:

```sh                                                                                                                                
pcm.quad_plug {                                                                                                                              
    type multi                                                                                                                               
    slaves.a.pcm "plughw:RAVENNA"                                                                                                                
    slaves.a.channels 2                                                                                                                      
    slaves.b.pcm "plughw:sndrpihifiberry"                                                                                                        
    slaves.b.channels 2                                                                                                                      
                                                                                                                                             
    bindings.0.slave a                                                                                                                       
    bindings.0.channel 0                                                                                                                     
    bindings.1.slave a                                                                                                                       
    bindings.1.channel 1                                                                                                                     
    bindings.2.slave a                                                                                                                       
    bindings.2.channel 0                                                                                                                     
    bindings.3.slave a                                                                                                                       
    bindings.3.channel 1                                                                                                                     
}

pcm.quad_plug2 {                                                                                                                             
    type plug                                                                                                                                
    slave.pcm "quad_plug"                                                                                                                         
}  
```
With `quad_plug` the same error occurs, with `quad_plug2` the error is as below:

```sh
$ alsaloop -C quad_plug2 -P alsadsp -c 4
Broken configuration for capture quad_plug2 PCM: no configurations available: Invalid argument
Unable to set parameters for capture quad_plug2 stream: Invalid argument
Loopback start failure.
```
Then the last thing I tried was to force the 48kHz sampling rate directly on the hardware devices with the help of the following config:

```sh
pcm.quad_48k {                    
    type multi                    
    slaves.a {                    
        pcm {                     
            type plug     
            slave.pcm "hw:RAVENNA"
            slave.rate 48000      
        }                         
        channels 2                
    }                             
                                  
    slaves.b {                    
        pcm {                     
            type plug             
            slave.pcm "hw:sndrpihifiberry"
            slave.rate 48000              
        }                                 
        channels 2                        
    }                                     
                                          
    bindings.0.slave a            
    bindings.0.channel 0          
    bindings.1.slave a            
    bindings.1.channel 1          
    bindings.2.slave b                    
    bindings.2.channel 0          
    bindings.3.slave b                    
    bindings.3.channel 1                  
}
```
and again it ends up with a failure:

```sh
$ alsaloop -C quad_48k -P alsadsp -c 4
Sample format not available for capture quad_48k: Invalid argument
Unable to set parameters for capture quad_48k stream: Invalid argument
Loopback start failure.
```

I know that both these cards are capable of running 48kHz, I'm doing that all the time. So what could be the cause of this error? `alsadsp` wants them to be 48kHz and if run separately it all works well, both cards set themselves according to `alsadsp` requirements. It works even if there's only one card in the multi plugin that occupies all 4 output ports - my conclusion is that it's not a problem of `alsadsp`.
Are there any other steps that could help solving the issue?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/273
Repository URL: https://github.com/alsa-project/alsa-lib
