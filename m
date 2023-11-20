Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4461FC54E76
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 08:25:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAC0FAE8;
	Mon, 20 Nov 2023 09:25:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAC0FAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700468750;
	bh=xjwOl+EiL520bbqvnqkBS8lF8XypGRF08JMu1eGSpnY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IwX+ZekJW7BRfrNeQMzqiQkGF4aqkXUxmkWV2XpJqsRsaTtJaZmDDhHCbQBv5PATL
	 JOX3aJ2eEJUBkny1w9ZqcZulJcDQq13EI6nWNODqp8SesYFnROFfaFpou1XahF05MZ
	 0ZzvV2/FqaGi8v7nrwyD7wC7RIaQ2ccXn28K+Yuo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55B1AF8055B; Mon, 20 Nov 2023 08:49:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2B59F80310;
	Mon, 20 Nov 2023 08:49:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6CD1F80310; Mon, 20 Nov 2023 08:46:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id D25DDF80254
	for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2023 08:46:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D25DDF80254
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1700466401577362776-webhooks-bot@alsa-project.org>
References: <1700466401577362776-webhooks-bot@alsa-project.org>
Subject: snd_pcm_readn hangs at record & playback on same device
Message-Id: <20231120074651.A6CD1F80310@alsa1.perex.cz>
Date: Mon, 20 Nov 2023 08:46:51 +0100 (CET)
Message-ID-Hash: TUP2KSOBC6ZUA5EYILNRTB4RA3VHLM25
X-Message-ID-Hash: TUP2KSOBC6ZUA5EYILNRTB4RA3VHLM25
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TUP2KSOBC6ZUA5EYILNRTB4RA3VHLM25/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #368 was opened from nodemand:

I'm on a RPi5 4GB running Raspberry Pi OS 64bit Bookworm and my application hangs on snd_pcm_readn when I try to read and write to the same device. This occurs on an IQAudio Codec Zero sound card and on a HifiBerry DAC+ADC Pro as well. When I select a USB sound card as the output and one of the others described for input everything works like it should. 

Here is my code:
`
#include <alsa/asoundlib.h>
#include <alsa/control.h>
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <algorithm>
#include <iterator>

typedef   signed short	drwav_int16;
typedef   signed int	drwav_int32;

#define PCM_DEVICE_IN "plughw:Zero,0"
#define PCM_DEVICE_OUT "plughw:Zero,0" //"plughw:Device,0"

int err, result, loops, n, t;
unsigned int rate, pcm, tmp;

snd_pcm_t			*play;
snd_pcm_t			*record;
snd_pcm_hw_params_t *playparams;
snd_pcm_hw_params_t *recordparams;
snd_pcm_uframes_t	frames;
snd_pcm_sframes_t	recresult;
snd_pcm_format_t	format = SND_PCM_FORMAT_S16_LE;
int                 block = 0;//SND_PCM_NONBLOCK;

int buffer_frames 			= 	1024;
int bits_per_frame 			= 	16;
const int bits_per_byte		= 	8;
int channels				= 	2;

int bytesize_per_channel  	= 	buffer_frames 
								* bits_per_frame 
								/ bits_per_byte;

int main(int argc, char **argv) {
	if (argc < 3) {
		printf("Usage: %s <sample_rate> <frames>\n", argv[0]);
		return -1;
	}

	rate			= atoi(argv[1]);
	buffer_frames	= atoi(argv[2]);
	
	bytesize_per_channel  	= 	buffer_frames 
								* snd_pcm_format_width(format)  
								/ bits_per_byte;

	drwav_int16 *buffer_in[channels];
	
	/* Open the PCM device in record mode */
	if ((pcm = snd_pcm_open(&record, PCM_DEVICE_IN, SND_PCM_STREAM_CAPTURE, block)) < 0)
		printf("ERROR: Can't open \"%s\" PCM device. %s\n", PCM_DEVICE_IN, snd_strerror(pcm));

	/* Allocate parameters object and fill it with default values*/
	if ((pcm = snd_pcm_hw_params_malloc(&recordparams)) < 0)
		printf("ERROR: Can't allocate hardware parameter structure. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_any(record, recordparams)) < 0)
		printf("ERROR: Can't initialize hardware parameter structure. %s\n", snd_strerror(pcm));

	/* Set parameters */
	if ((pcm = snd_pcm_hw_params_set_access(record, recordparams, SND_PCM_ACCESS_RW_NONINTERLEAVED )) < 0) 
		printf("ERROR: Can't set interleaved mode. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_set_format(record, recordparams, format)) < 0)
		printf("ERROR: Can't set format. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_set_channels(record, recordparams, channels)) < 0) 
		printf("ERROR: Can't set channels number. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_set_rate_near(record, recordparams, &rate, 0)) < 0) 
		printf("ERROR: Can't set sample rate. %s\n", snd_strerror(pcm));

	/* Write parameters */
	if ((pcm = snd_pcm_hw_params(record, recordparams)) < 0)
		printf("ERROR: Can't set hardware parameters. %s\n", snd_strerror(pcm));
		
	if ((pcm = snd_pcm_prepare(record)) < 0)
   	 	printf("ERROR: Can't prepare audio interface for use. %s\n", snd_strerror(pcm));
	
    if ((pcm = snd_pcm_start(record)) < 0)
		printf("ERROR: Can't start hardware soundcard. %s\n", snd_strerror(pcm));
		
	/* Resume information */
	printf("PCM name: '%s'\n", snd_pcm_name(record));

	printf("PCM state: %s\n", snd_pcm_state_name(snd_pcm_state(record)));

	snd_pcm_hw_params_get_channels(recordparams, &tmp);
	printf("channels: %i ", tmp);

	if (tmp == 1)
		printf("(mono)\n");
	else if (tmp == 2)
		printf("(stereo)\n");

	snd_pcm_hw_params_get_rate(recordparams, &tmp, 0);
	printf("sample rate: %d bps\n", tmp);
	
	
	
	/* Open the PCM device in playback mode */
	if ((pcm = snd_pcm_open(&play, PCM_DEVICE_OUT, SND_PCM_STREAM_PLAYBACK, block)) < 0)
		printf("ERROR: Can't open \"%s\" PCM device. %s\n", PCM_DEVICE_OUT, snd_strerror(pcm));
		
	if ((pcm = snd_pcm_hw_params_malloc(&playparams)) < 0)
		printf("ERROR: Can't allocate hardware parameter structure. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_any(play, playparams)) < 0)
		printf("ERROR: Can't initialize hardware parameter structure. %s\n", snd_strerror(pcm));

	/* Set parameters */
	if ((pcm = snd_pcm_hw_params_set_access(play, playparams, SND_PCM_ACCESS_RW_NONINTERLEAVED )) < 0) 
		printf("ERROR: Can't set interleaved mode. %s\n", snd_strerror(pcm));
		
	if ((pcm = snd_pcm_hw_params_set_format(play, playparams, format)) < 0)
		printf("ERROR: Can't set format. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_set_channels(play, playparams, channels)) < 0) 
		printf("ERROR: Can't set channels number. %s\n", snd_strerror(pcm));

	if ((pcm = snd_pcm_hw_params_set_rate_near(play, playparams, &rate, 0)) < 0) 
		printf("ERROR: Can't set sample rate. %s\n", snd_strerror(pcm));

	/* Write parameters */
	if ((pcm = snd_pcm_hw_params(play, playparams)) < 0)
		printf("ERROR: Can't set hardware parameters. %s\n", snd_strerror(pcm));
		
	if ((pcm = snd_pcm_prepare(play)) < 0)
   	 	printf("ERROR: Can't prepare audio interface for use. %s\n", snd_strerror(pcm));
	
    if ((pcm = snd_pcm_start(play)) < 0)
		printf("ERROR: Can't start hardware soundcard. %s\n", snd_strerror(pcm));
	
	/* Resume information */
	printf("PCM name: '%s'\n", snd_pcm_name(play));

	printf("PCM state: %s\n", snd_pcm_state_name(snd_pcm_state(play)));

	snd_pcm_hw_params_get_channels(playparams, &tmp);
	printf("channels: %i ", tmp);

	if (tmp == 1)
		printf("(mono)\n");
	else if (tmp == 2)
		printf("(stereo)\n");

	snd_pcm_hw_params_get_rate(playparams, &tmp, 0);
	printf("sample rate: %d bps\n", tmp);
	
	buffer_in[0]	= (drwav_int16*) malloc(bytesize_per_channel);
	buffer_in[1] 	= (drwav_int16*) malloc(bytesize_per_channel);
	
	printf("buffers allocated: %d bytes per channel\n", bytesize_per_channel);
	
	for (loops = 0; loops < 25000; loops++)
	{

        if ((recresult = snd_pcm_readn(record, (void**) buffer_in, buffer_frames)) < 0) {
             printf ("ERROR. Read from audio interface failed. (%s)\n", snd_strerror(recresult));
            exit(1);
        }
        n = (int) recresult;
        printf("read %d done, %d frames\n", loops, n);
		
		if ((result = snd_pcm_writen(play, (void**) buffer_in, recresult)) == -EPIPE) {
			printf("XRUN.\n");
			snd_pcm_prepare(play);
		} else if (result < 0) {
			printf("ERROR. Can't write to playback device. %s\n", snd_strerror(result));
			exit(1);
		}
		printf("write %d done\n", loops);
	}

	snd_pcm_hw_params_free(playparams);
	snd_pcm_hw_params_free(recordparams);
	printf("params freed\n");
	
	snd_pcm_drain(play);
	snd_pcm_close(play);
	snd_pcm_drain(record);
	snd_pcm_close(record);
	printf("audio interface closed\n");
	
	free(buffer_in[0]);
	free(buffer_in[1]);
	printf("buffers freed\n");

	return 0;
}
`

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/368
Repository URL: https://github.com/alsa-project/alsa-lib
