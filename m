From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Mixer volume/decibel mapping
Date: Sat, 29 May 2010 19:46:00 +0100
Message-ID: <htrnci$n76$1@dough.gmane.org>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	<4BF629B3.9020904@ladisch.de>	<201005210951.36495.peter.ujfalusi@nokia.com>	<4BF658C6.4030404@ladisch.de>	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>	<4BFB8C89.3010207@ladisch.de>	<AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
	<AANLkTil5vvUPaapxjXgbqBsMS7oEZcrUW75DTMk_WVcm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7578C243EE
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 20:45:49 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OIR2a-0006gk-NE
	for alsa-devel@alsa-project.org; Sat, 29 May 2010 20:45:48 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 29 May 2010 20:45:48 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 29 May 2010 20:45:48 +0200
In-Reply-To: <AANLkTil5vvUPaapxjXgbqBsMS7oEZcrUW75DTMk_WVcm@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 29/05/10 02:57 did gyre and gimble:
> 2010/5/25 James Courtier-Dutton <james.dutton@gmail.com>
> 
>>
>> Could this maybe explain why pulseaudio was having such problems with
>> alsa with regards to gain controls????
>>
> 
> 
> Did you answer PA 's developer 's question in FOMS
> 
> http://thread.gmane.org/gmane.linux.alsa.devel/50417/focus=50555
> 
> what is the answer of this question ?

What question? I'm not sure I follow what you're asking here...

> - That snd_pcm_sw_params_set_start_threshold(.. , (snd_pcm_uframes_t) -1))
>   disables automatic stopping on underrun.
> 
> snd_pcm_uframes_t is unsigned and in snd_pcm_write_areas() pcm/pcm.c
> 
> start_threshold seem used as a signed number
> 
> is this a special case , what is the difference between 1 and -1 ?
> 
> 		if (state == SND_PCM_STATE_PREPARED) {
> 			snd_pcm_sframes_t hw_avail = pcm->buffer_size - avail;
> 			hw_avail += frames;
> 			/* some plugins might automatically start the stream */
> 			state = snd_pcm_state(pcm);
> 			if (state == SND_PCM_STATE_PREPARED &&
> 			    hw_avail >= (snd_pcm_sframes_t) pcm->start_threshold) {
> 				err = snd_pcm_start(pcm);
> 				if (err < 0)
> 					goto _end;
> 			}
> 		}


It seems to be used as a signed value there, but I'm not sure if the
unsigned -1 case is treated differently in some capacity prior to
reaching this code.

The reason -1 is used is just a shortcut to get the maximum value of an
unsigned variable. I presume this "as big as possible" case is dealt
with appropriately.

I'm absolutely green when it comes to alsa lib API and programming, so
you'd be better asking Lennart directly about this.

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
