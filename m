From: "John L. Utz III" <jutz@dmx.com>
Subject: Re: Controling wave amplitude using alsa api !! (pcm
 interface ???????)
Date: Tue, 04 Aug 2009 10:08:12 -0700
Message-ID: <4A786AFC.3030809@dmx.com>
References: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
	<4A7863EB.5090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DBA8244BD
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 19:08:25 +0200 (CEST)
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
To: Guilherme Longo <grlongo.ireland@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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

This line int pcm.c is not amplitude control?

unsigned int maxval = (1 << (snd_pcm_format_width(format) - 1)) - 1;

it's an int, so you probably need to alter this a bit to allow you to
have arbitrary control over the amplitude (ie: multiply by a float less
than 1.0)

HTH

johnu


> * I don't want to control the volume using alsamixer or even my sound... 
> I want to generate a wave with predefined amplitude.
> 
> Does anyone could give me a little help??
> 
> Thanks a lot!
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
