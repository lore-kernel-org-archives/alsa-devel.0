From: Peter Lukac <p.lukac@emtest.sk>
Subject: open sound device from asound.conf
Date: Fri, 23 Jul 2010 11:12:24 +0200
Message-ID: <201007231112.24764.p.lukac@emtest.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sly.emtest.sk (mail-hub.emtest.sk [158.193.4.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 46A27103825
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 11:12:27 +0200 (CEST)
Received: from sly.emtest.sk (localhost [127.0.0.1])
	by esets (Postfix) with ESMTP id 376C723548E8
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 11:12:20 +0200 (CEST)
Received: from fokus.localnet (unknown [192.168.10.123])
	by sly.emtest.sk (Postfix) with ESMTP id 156B323548E7
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 11:12:20 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hello all
maybe trivial question...

I want open sound device from /etc/asound.conf with API
snd_pcm_open() but unsuccessfull. As name i'm used:

"plughw:0,0"
"plughw:0,1"
"plughw:0,2"
"plughw:1,0"
"plughw:1,1"
"plughw:1,2"
...
i'm try alternative name with "hw:X,Y"
"hw:0,0"
"hw:0,1"
...
but in this method i'm open only HW device.
I'm get follow error:
ALSA lib pcm_hw.c:1429:(_snd_pcm_hw_open) Invalid value for card 

how can i open my "virtual" device in asound.conf

here is asound.conf:


pcm.!default {
        type plug
        slave.pcm "output"
    }

pcm.output {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"
        channels 2
        rate 44100
        format S16_LE
    }
}

pcm.dsp0 {
    type plug
    slave.pcm "output"
}

...exists some universal method how can i open all HW device and "virtual" 
devices?

thanks
