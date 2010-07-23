From: "Sebastian H." <vand2@gmx.de>
Subject: Re: open sound device from asound.conf
Date: Fri, 23 Jul 2010 12:12:41 +0200
Message-ID: <4C496B19.8020707@gmx.de>
References: <201007231112.24764.p.lukac@emtest.sk> <4C49603D.4090807@gmx.de>
	<201007231143.21344.p.lukac@emtest.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 303971039D2
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 12:16:03 +0200 (CEST)
In-Reply-To: <201007231143.21344.p.lukac@emtest.sk>
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

>>> I want open sound device from /etc/asound.conf with API
>>> snd_pcm_open() but unsuccessfull. As name i'm used:
>>
>> Did you try to open "default", "output" or "dsp0" since these are the
>> names of your pcm defines?
> 
> thanks for reply...
> Yes it works..(device is open) but i don't want open device with "hard coded" 
> name because this name can be changed..I want to use iterations

I'm just a user but I guess you would have to parse the pcm subsection
of the Alsa configuration tree with the snd_config_* functions.

http://www.alsa-project.org/alsa-doc/alsa-lib/group___config.html

Sebastian
