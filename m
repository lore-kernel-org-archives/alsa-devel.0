From: melwyn lobo <linux.melwyn@gmail.com>
Subject: XRUN handling
Date: Tue, 6 Jul 2010 10:33:57 +0530
Message-ID: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id B105A24488
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 07:04:02 +0200 (CEST)
Received: by vws9 with SMTP id 9so3476709vws.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 22:04:00 -0700 (PDT)
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

Hi all,
I have noticed when an Xrun occurs, the bytes between the hw_ptr and
appl_ptr are not copied when both hw and appl pointers are reset in
snd_pcm_prepare().
Consider the following parameters:
  buffer_size  : 22352
  period_size  : 1016
  period_time  : 23038
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1016
  period_event : 0
  start_threshold  : 22352
  stop_threshold   : 22352
  silence_threshold: 0
  silence_size : 0

In case snd_pcm_playback_avail() is less than stop threshold but
greater than 0, then these bytes are missing after Xrun prepare and
start stage.

Is my analysis correct? If so how do we ensure correct behaviour ie
byte accuracy after Xrun.

Thanks,
M.
