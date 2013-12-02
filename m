From: Dolevo Jay <cmst@live.com>
Subject: Re: Intermittent cut out on the video
Date: Mon, 2 Dec 2013 09:47:16 +0000
Message-ID: <DUB122-W150AA077A26EF2F1581D57AAEA0@phx.gbl>
References: <DUB122-W30D40465C0A432A2147375AAEC0@phx.gbl>,
 <DUB122-W83C8D065397526DB034BAAAEE0@phx.gbl>, <5296FEF9.2020604@ladisch.de>,
 <DUB122-W22A2B2F1172BAEC057087BAAEA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s35.dub0.hotmail.com (dub0-omc3-s35.dub0.hotmail.com
 [157.55.2.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5BAEA2619F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 10:47:17 +0100 (CET)
In-Reply-To: <DUB122-W22A2B2F1172BAEC057087BAAEA0@phx.gbl>
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


From: cmst@live.com
To: clemens@ladisch.de
Subject: RE: [alsa-devel] Intermittent cut out on the video
Date: Mon, 2 Dec 2013 09:44:16 +0000






> Date: Thu, 28 Nov 2013 09:29:45 +0100
> From: clemens@ladisch.de
> To: cmst@live.com; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Intermittent cut out on the video
> 
> Dolevo Jay wrote:
> > I have two sound cards on my system and I use the [multi plugin] to
> > have audio from two jacks simultaneously.
> >
> > The audio coming from the jack on the pc is cutting out intermittently.
> > It just cuts out for a fraction of a second and continues as normal
> > and after some time it happens again.
> 
> The two cards use different sample clocks, so it is not possible to feed
> them reliably from the same stream.
> 
> You would need software that measures that actual sample rate of both
> devices and resamples its output appropriately.  Try using PulseAudio.
> 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Hi,

I have tried to apply 
pulseaudio but couldn't really manage it. Could you please tell me if I can 
fix it in the configuration file? I mean, for example, would it be solved if I resample the
 audio for the appropriate sound card in the asound.conf? What other 
option do I have other than pulseaudio?

Thanks a lot.

 		 	   		   		 	   		  
