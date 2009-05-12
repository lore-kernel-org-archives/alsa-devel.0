From: jinjin xu <freebsdxjj@gmail.com>
Subject: ALSA for SoC audio support full duplex problem
Date: Tue, 12 May 2009 17:53:52 +0800
Message-ID: <8fda62c20905120253u42a7f1f9i723888c44541b46f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C0D7103830
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 11:53:53 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so2595387ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 02:53:52 -0700 (PDT)
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

Dear All.

I use 2.6.21.5-cfs-v19 on S3C6410(arm),use wm8987 sound card(i2s interface)

It is not use in full duplex.
I grep and diff the drivers

ens1370.c:

  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ensoniq_playback1_ops);

  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ensoniq_capture_ops);


soc-core.c:

        if (playback)
        {

                snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);

        }

        if (capture)
        {

                snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
        }


ens1370.c use two different fops for playback and record(I test it in
Vmware,It can run on full duplex)
soc-core.c use the same fops for  playback and record

It that the problem ?
So how to fix it for support full duplex?

Thanks!
