From: Prasant J <pj0585@gmail.com>
Subject: sw_params configuration clarification
Date: Mon, 17 Sep 2012 15:38:49 +0530
Message-ID: <CAA2DH4sNObZ52+hjX9F5y_qZT2raxL3kQJT7_pstDH=GO9CTQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 10DAC261665
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 12:08:49 +0200 (CEST)
Received: by qadz3 with SMTP id z3so1883960qad.17
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 03:08:49 -0700 (PDT)
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

Hi,

I'm using ALSA API (alsa-lib 1.0.25) for writing an audio application
for an embedded product.

This is my understanding of the sw_params configuration api: (Can
someone please confirm if the explanation is correct?)


snd_pcm_sw_params_set_start_threshold -- sets the minimum no. of
frames before which playback will not start.

snd_pcm_sw_params_stop_threshold -- sets the minimum no. of frames
when the playback stops (not completely clear)

snd_pcm_sw_params_set_silence_threshold -- sets the no. of frames for
inserting silence (equal to set by set_silence_size) when frames is
less than the value set.


Any info will be of help.

-Prasant
