From: Jamey Sharp <jamey@minilop.net>
Subject: pcm_hw bug when calling snd_pcm_sw_params twice
Date: Mon, 7 Jan 2019 15:26:20 -0800
Message-ID: <20190107232620.GA11810@eh>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by alsa0.perex.cz (Postfix) with ESMTP id E7B032666B3
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2019 00:26:25 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id 64so913758pfr.9
 for <alsa-devel@alsa-project.org>; Mon, 07 Jan 2019 15:26:25 -0800 (PST)
Received: from eh ([140.211.16.99])
 by smtp.gmail.com with ESMTPSA id m11sm89452774pgh.51.2019.01.07.15.26.21
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 15:26:22 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I would have reported this to your bug tracker, but I can't find it; the
links on alsa-project.org are dead.

I've attached a small test program that demonstrates that calling
snd_pcm_sw_params twice changes the value of the period_event flag in
the sw_params struct, at least on pcm_hw devices.

In src/pcm/pcm_hw.c, in snd_pcm_hw_sw_params, there's an early
`sw_set_period_event(params, 0)` call. Its effect is not undone if the
function returns early. This is easiest to trigger by calling it with
unchanged parameters, although there are other early-exit paths with the
same problem.

I don't actually care about this bug, but since I noticed it while
reading the alsa-lib source code trying to figure out what a period
event is for, I thought I'd go ahead and report it.

Jamey

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa_period_event.c"

#define _GNU_SOURCE
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

#define check(v) if(v < 0) { perror(#v); exit(1); }

int main(void)
{
	snd_pcm_t *handle;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_sw_params_t *sw_params;
	int val = 0;
	char *name = getenv("DEVICE");

	snd_pcm_hw_params_alloca(&hw_params);
	snd_pcm_sw_params_alloca(&sw_params);

	if(!name)
		name = "hw:0";
	printf("opening %s\n", name);

	check(snd_pcm_open(&handle, name, SND_PCM_STREAM_PLAYBACK, 0));
	check(snd_pcm_hw_params_any(handle, hw_params));
	check(snd_pcm_hw_params(handle, hw_params));
	check(snd_pcm_sw_params_current(handle, sw_params));

	// Enable the period event
	check(snd_pcm_sw_params_set_period_event(handle, sw_params, 1));
	check(snd_pcm_sw_params_get_period_event(sw_params, &val));
	assert(val == 1);

	// After applying sw params once, the params struct still says the
	// period event is enabled.
	check(snd_pcm_sw_params(handle, sw_params));
	check(snd_pcm_sw_params_get_period_event(sw_params, &val));
	assert(val == 1);

	// Applying the same sw params a second time should still leave the
	// period event enabled, but this assert fails.
	check(snd_pcm_sw_params(handle, sw_params));
	check(snd_pcm_sw_params_get_period_event(sw_params, &val));
	assert(val == 1);

	return 0;
}

--ibTvN161/egqYuK8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--ibTvN161/egqYuK8--
