From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Sat, 29 May 2010 09:57:43 +0800
Message-ID: <AANLkTil5vvUPaapxjXgbqBsMS7oEZcrUW75DTMk_WVcm@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
	<4BFB8C89.3010207@ladisch.de>
	<AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id BAB6E24414
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 03:57:44 +0200 (CEST)
Received: by pvd12 with SMTP id 12so236274pvd.38
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2010 18:57:43 -0700 (PDT)
In-Reply-To: <AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/25 James Courtier-Dutton <james.dutton@gmail.com>

>
> Could this maybe explain why pulseaudio was having such problems with
> alsa with regards to gain controls????
>


Did you answer PA 's developer 's question in FOMS

http://thread.gmane.org/gmane.linux.alsa.devel/50417/focus=50555

what is the answer of this question ?

- That snd_pcm_sw_params_set_start_threshold(.. , (snd_pcm_uframes_t) -1))
  disables automatic stopping on underrun.

snd_pcm_uframes_t is unsigned and in snd_pcm_write_areas() pcm/pcm.c

start_threshold seem used as a signed number

is this a special case , what is the difference between 1 and -1 ?

		if (state == SND_PCM_STATE_PREPARED) {
			snd_pcm_sframes_t hw_avail = pcm->buffer_size - avail;
			hw_avail += frames;
			/* some plugins might automatically start the stream */
			state = snd_pcm_state(pcm);
			if (state == SND_PCM_STATE_PREPARED &&
			    hw_avail >= (snd_pcm_sframes_t) pcm->start_threshold) {
				err = snd_pcm_start(pcm);
				if (err < 0)
					goto _end;
			}
		}
