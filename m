From: K.Fetscher@t-online.de (Klaus Fetscher)
Subject: Re: Driver Programming
Date: Mon, 29 Nov 2004 09:37:39 +0100
Message-ID: <41AADFD3.6030001@fetron.de>
References: <200411290327.iAT3RTlT019644@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411290327.iAT3RTlT019644@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Klaus Fetscher <K.Fetscher@t-online.de>, Clemens Ladisch <clemens@ladisch.de>, Giuliano Pochini <pochini@shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis schrieb:

>>Is it possible, to select a substream with aplay ?
>>    
>>
>
>aplay -D hw:stream,substream
>
>  
>
Okay, I found my error. No, I am calling snd_pcm_new(chip->card, "name", 
DEV_x, ONE_OUT, ONE_IN, &pcm); three times. During the last call, the 
parameter ONE_IN is 0 (because I only have three output channels and two 
input channels).

When I list the /proc/asound/card0 directory, I can see pcm0c, pcm1c, 
pcm0p, pcm1p, pcm2p. And with substream->pcm->device I can detect, which 
device I am using. All seems to be okay.

Another question belonging to the Control names of the mixer. Is it 
correct, to use "Master Volume" three times for the different output 
channels (the channels are independent from each other) ?

Thanks,

Klaus



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
