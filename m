From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Sun, 6 Mar 2011 22:49:28 +1100
Message-ID: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id BA618243FF
	for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2011 12:49:29 +0100 (CET)
Received: by ywg4 with SMTP id 4so1531046ywg.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Mar 2011 03:49:28 -0800 (PST)
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

Hi there.

I'm a bit puzzled as to what values are considered valids and which
one aren't when it comes to setting the buffer time with
snd_pcm_hw_params_set_buffer_time_near.

For example setting a value of 295ms : all ok. From 300ms to 450ms ->
"Invalid argument".
but 500ms for example is okay.

What's the logic behind it ?
It's obviously related to the sampling rate, the audio format and the
number of channels ; as the values giving me "Invalid argument" change
then.

Any comments would be greatly appreciated.

Thanks!
JY
