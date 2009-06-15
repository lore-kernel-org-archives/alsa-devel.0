From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5]
	ASoC	codec:	SSM2602: assign last substream to the master
	when	shutting down
Date: Mon, 15 Jun 2009 10:40:47 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA0434E648@chinexm1.ad.analog.com>
References: <20090603105223.GE11507@sirena.org.uk><8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com><20090603145316.GA7315@rakim.wolfsonmicro.main><8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com><20090604085921.GD6983@rakim.wolfsonmicro.main><ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com><20090613104435.GA4795@sirena.org.uk><8bd0f97a0906130347x74973be2nf5c26641a09c5e24@mail.gmail.com><20090613105911.GB4795@sirena.org.uk><8bd0f97a0906130403k29956684j6caeae40e16b1e6@mail.gmail.com><20090613110607.GA8052@opensource.wolfsonmicro.com>
	<s5hiqiztemq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id BCF0A2414F
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 04:37:10 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <s5hiqiztemq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de] 
>Sent: Sunday, June 14, 2009 4:16 PM
>To: Mark Brown
>Cc: Mike Frysinger; Karl Beldan; 
>uclinux-dist-devel@blackfin.uclinux.org; 
>alsa-devel@alsa-project.org; Cai, Cliff
>Subject: Re: [alsa-devel] [Uclinux-dist-devel] [PATCH 2/5] 
>ASoC codec: SSM2602: assign last substream to the master when 
>shutting down
>
>At Sat, 13 Jun 2009 12:06:07 +0100,
>Mark Brown wrote:
>> 
>> On Sat, Jun 13, 2009 at 07:03:12AM -0400, Mike Frysinger wrote:
>> 
>> > the first part conditionalized the constraints.  ignoring 
>whitespace 
>> > changes, this is the diff:
>> > +if (master_runtime->rate != 0)
>> >     snd_pcm_hw_constraint_minmax(substream->runtime,
>> >     ......
>> > +if (master_runtime->sample_bits != 0)
>> >     snd_pcm_hw_constraint_minmax(substream->runtime,
>> >     ......
>> 
>> > or maybe that is what you're saying and i dont know alsa
>> 
>> That's not a bad change - there's a thin race condition if you 
>> simultaneously start up two applications where the primary substream 
>> could be there but not yet configured since stream startup 
>is separate 
>> to the configuration of the stream.  It's hard but not impossible to 
>> reproduce.
>
>An absolute race-free hw-constraint for multiple substreams is 
>actually difficult to implement.  The best practice would be 
>to give an error and refuse the change when any inconsistency 
>occurs, IMO.
>


Without this patch, Oss-based applications (such as "tone","vplay" etc.)
won't work properly.  

Cliff
