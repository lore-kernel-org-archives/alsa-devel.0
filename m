From: Sanjeev Chugh <sanjuchugh@gmail.com>
Subject: snd_pcm_drain causes repeated playback of last buffer
	contents
Date: Wed, 12 Mar 2014 17:50:34 +0530
Message-ID: <CAKsFLLhgGgqFCZT9F86B7=wYtn9tST=byziSt248naBEo2qxzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C02261A97
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 13:20:35 +0100 (CET)
Received: by mail-ee0-f45.google.com with SMTP id d17so4259795eek.18
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 05:20:35 -0700 (PDT)
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

Hello,



I'm not an alsa expert at all but trying to learn alsa.



I'm experiencing an issue where on snd_pcm_drain() the slave PCM driven via
plugin DSHARE is not filled with silence.

Result is endless playback of buffer content until pcm is closed.



I'm trying to analyze what could be the reason for this. In my
understanding in Alsa, audio data is played as a unit of period. Once
playing one period is finished, then next period will be played. If period
has lesser frames than the period size, audio data previously played will
be re-played until pcm is closed out. Could it be a reason for this
continuous playback when snd_pcm_drain is called ?



I'm not even sure if it is desired behavior that silence be padded after
driver drains the pcm :( I guess it is too big as a bug to be ignored.



Thanks

Pthread
