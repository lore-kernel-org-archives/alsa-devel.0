From: "Arve Knudsen" <arve.knudsen@gmail.com>
Subject: snd_pcm_drain and lockups
Date: Tue, 4 Sep 2007 23:03:27 +0200
Message-ID: <a0d6258d0709041403s5e084541q203af02df22458eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 92EF72433D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 23:03:29 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so1171416nzf
	for <alsa-devel@alsa-project.org>; Tue, 04 Sep 2007 14:03:28 -0700 (PDT)
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

Users of the PortAudio library on top of ALSA-lib have reported that it may
hang in a call to snd_pcm_drain. I have also been able to confirm that this
can happen in conjunction with the dmix device at least. Can the ALSA
developers please tell me how, if at all, snd_pcm_drain may be safely used?
Is this function simply best avoided (snd_pcm_drop being the alternative)?

Thanks,
Arve Knudsen
