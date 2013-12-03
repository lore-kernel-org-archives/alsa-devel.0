From: Dolevo Jay <cmst@live.com>
Subject: Re: Intermittent cut out on the video
Date: Tue, 3 Dec 2013 15:43:39 +0000
Message-ID: <DUB122-W24AEFB005C0041C03515A7AAD50@phx.gbl>
References: <DUB122-W30D40465C0A432A2147375AAEC0@phx.gbl>, ,
 <DUB122-W83C8D065397526DB034BAAAEE0@phx.gbl>,
 <5296FEF9.2020604@ladisch.de>, , <DUB122-W22A2B2F1172BAEC057087BAAEA0@phx.gbl>,
 <DUB122-W150AA077A26EF2F1581D57AAEA0@phx.gbl>, <529DD914.7060205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s13.dub0.hotmail.com (dub0-omc3-s13.dub0.hotmail.com
 [157.55.2.22]) by alsa0.perex.cz (Postfix) with ESMTP id 6E542261A1B
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 16:43:40 +0100 (CET)
In-Reply-To: <529DD914.7060205@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> Date: Tue, 3 Dec 2013 14:13:56 +0100
> From: clemens@ladisch.de
> To: cmst@live.com; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Intermittent cut out on the video
> 
> Dolevo Jay wrote:
> >> You would need software that measures that actual sample rate of both
> >> devices and resamples its output appropriately.  Try using PulseAudio.
> >
> > I have tried to apply pulseaudio but couldn't really manage it.
> 
> http://www.freedesktop.org/wiki/Software/PulseAudio/FAQ/#index31h3
> 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

I think this is not what I want. I don't want to combine the two sound cards. I want to route the audio being played on one sound card to the other sound card. I have found the following answer:
http://askubuntu.com/questions/168333/routing-sound-from-different-cards-to-a-single-output

So with the following line:

pactl load-module module-loopback source=<name_or_index> sink=<name_or_index>

I should be able to achieve what I want. However, I know no pulseaudio and I got some issues with it already. 

For example,
I start the pulseaudio with  

root@dolevo:~# start-pulseaudio-kde
W: [pulseaudio] main.c: This program is not intended to be run as root (unless --system is specified).

I guess it starts working properly after this call. However, I call

pactl list

to get the list of the devices but I get 

root@dolevo:~# pactl list
Connection failure: Connection refused
pa_context_connect() failed: Connection refused

So, what should I put as source and sink? I have already tried calling the following:

pactl load-module module-loopback source=hw:1,0 sink=0,3

However I again receive:

Connection failure: Connection refused
pa_context_connect() failed: Connection refused

I would appreciate if you could help.
 		 	   		  
