From: "Paulos Siahu" <psiahu@gmail.com>
Subject: snd_pcm_writei error 128 Key has been revoked
Date: Sun, 7 Sep 2008 08:01:21 +1000
Message-ID: <f6e684990809061501u7ab48a2cld137f13a43135fbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 006FE24557
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 00:01:23 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so536560tid.8
	for <alsa-devel@alsa-project.org>; Sat, 06 Sep 2008 15:01:21 -0700 (PDT)
Content-Disposition: inline
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

Hello

I'm a newbie to ALSA, in fact to sound programming at all. I tried a simple
program for a beginner. When I got to this line:

        err = snd_pcm_writei (playback_handle, buf, bufsize);
        printf("Playing Error: %d %s\n", err, snd_strerror(err));

the first time it played the sound that I wanted then I Ctrl-C the app. From
then on, every time I run the program it gives me: Playing Error: 128 Key
has been revoked

I tried to google around but no luck.
Hope someone can  help.

Thanks
Paulos Siahu
