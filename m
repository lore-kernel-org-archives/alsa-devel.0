From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Driver Programming
Date: Mon, 29 Nov 2004 10:19:44 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411291004150.13337@denise.shiny.it>
References: <200411290327.iAT3RTlT019644@localhost.localdomain>
 <41AADFD3.6030001@fetron.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41AADFD3.6030001@fetron.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Klaus Fetscher <K.Fetscher@t-online.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Mon, 29 Nov 2004, Klaus Fetscher wrote:

> Okay, I found my error. No, I am calling snd_pcm_new(chip->card, "name",
> DEV_x, ONE_OUT, ONE_IN, &pcm); three times. During the last call, the
> parameter ONE_IN is 0 (because I only have three output channels and two
> input channels).
>
> When I list the /proc/asound/card0 directory, I can see pcm0c, pcm1c,
> pcm0p, pcm1p, pcm2p. And with substream->pcm->device I can detect, which
> device I am using. All seems to be okay.

If you want to play a 6-channel track you have to open all tree devices
and the hw should support sync-start. (There was a typo in the my message:
THREE_OUT and TWO_IN should have been 6 and 4).


> Another question belonging to the Control names of the mixer. Is it
> correct, to use "Master Volume" three times for the different output
> channels (the channels are independent from each other) ?

I don't think so.  IMO you should register one "Master Volume" as an
int[6]. or maybe you can register three "Master Volume n". Applications
will have problems accessing them anyway :)


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
