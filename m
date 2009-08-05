From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: Re: Controling wave amplitude using alsa api !! (pcm
	interface ???????)
Date: Wed, 05 Aug 2009 08:35:49 -0300
Message-ID: <4A796E95.6080008@gmail.com>
References: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
	<4A7863EB.5090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id F17C01037F9
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 13:36:01 +0200 (CEST)
Received: by qyk15 with SMTP id 15so12596qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 04:36:00 -0700 (PDT)
In-Reply-To: <4A7863EB.5090207@gmail.com>
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

Hi again.

I've got half of my work done with it. I found the values of the samples 
been analyzed, **BUT* *it is given in a strange unity!

while (count-- > 0) {
                 res = sin(phase) * 15000;
                 ires.i = res;
                 tmp = ires.c;
               * printf("som -> %g\n", res);  // Here I get the values*
                 for (chn = 0; chn < channels; chn++) {
                        for (byte = 0; byte < (unsigned int)bps; byte++)
                                 *(samples[chn] + byte) = tmp[1];
                                  samples[chn] += steps[chn];
                 }

Now, how can I transform this samples in a more human understandable 
notation as in Db unity for example?
Is there any alsa api function to control it? Should I use the mixer  
interface somehow?

This is the output:

som -> 11976.3
som -> 11387
som -> 10752.9
som -> 10076.6
som -> 9360.7
som -> 8608.02
som -> 7821.53
som -> 7004.31
som -> 6159.56
som -> 5290.63
som -> 4400.9
som -> 3493.89
som -> 2573.15
som -> 1642.3
som -> 704.996
som -> -235.076
som -> -1174.22
som -> -2108.76
som -> -3035.01
som -> -3949.33
som -> -4848.14
som -> -5727.91

Thanks!
Guilherme Longo wrote:
> Hi all!
>
> Mates, I am following the example PCM.C that I found at alsa web site. 
> its a sine wave generator.
> I am looking for a control that alsa provides to control the amplitude 
> of the wave.
>
> As I could found so for, there is just frequency control... I didn't 
> find any amplitude control.
>
> * I don't want to control the volume using alsamixer or even my 
> sound... I want to generate a wave with predefined amplitude.
>
> Does anyone could give me a little help??
>
> Thanks a lot!
>
>
