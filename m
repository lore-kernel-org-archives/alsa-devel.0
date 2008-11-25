From: "John Kacur" <jkacur@gmail.com>
Subject: pcm_prepare, and pcm_trigger
Date: Tue, 25 Nov 2008 14:59:46 +0100
Message-ID: <520f0cf10811250559r4f57297fi663a3cbd7608a08a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id A70022444C
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 14:59:47 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2484857rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 05:59:46 -0800 (PST)
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

More ASoC fundamentals questions.

when doing

cat 8k8bitpcm.wav > /dev/dsp

I'm seeing neither

        myplatform_pcm_prepare,

nor

       myplatform_pcm_trigger

called.

Is this normal? Who calls these functions?

Thanks
