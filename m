From: Metathronius Galabant <m.galabant@googlemail.com>
Subject: Strange behaviour with varying frame sizes on read
Date: Wed, 29 Jul 2009 11:13:05 +0200
Message-ID: <1b270aae0907290213v1569fb05xe8c37d6359250d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 85CC010384B
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 11:13:07 +0200 (CEST)
Received: by bwz23 with SMTP id 23so577761bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 02:13:06 -0700 (PDT)
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

please consider the following:
Period size is 80 frames, buffer size is 320 frames.
For all 3 tests I have 240 frames ready to read.
snd_pcm_avail_update() confirms this.

Outcome of my tests:
1) I want to read 80 frames, and get 80 frames. - OK, this is really basic.
2) I want to read 81 frames, and get 80 frames. - FAIL.
3) I want to read 80 frames, and get 80 frames. Then I read 1 frame,
and get 1 frame. - HUH?

I've both tested snd_pcm_readi() and snd_pcm_mmap_readi() - both have
the same semantic.
Is there any explanation for this kind of illogical behaviour (I have
version 1.0.14, which might be a bit old, but still)?
I should be able to read rather arbitrary amounts from a software
buffer, don't I?

Cheers,
M.
