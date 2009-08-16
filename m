From: Daniel Chen <seven.steps@gmail.com>
Subject: Strange div-by-zero in alsa-lib 1.0.20's
	snd_pcm_mmap_begin()
Date: Sun, 16 Aug 2009 18:24:35 -0400
Message-ID: <604760770908161524w207a4a44m72793fa9438c2ef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f205.google.com (mail-bw0-f205.google.com
	[209.85.218.205])
	by alsa0.perex.cz (Postfix) with ESMTP id D59A62453E
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 00:24:36 +0200 (CEST)
Received: by bwz1 with SMTP id 1so2302710bwz.46
	for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2009 15:24:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

In https://bugs.launchpad.net/ubuntu/+source/alsa-lib/+bug/412677
we're debugging an issue where snd_pcm_mmap_begin(), at line 6409 with

*offset = *pcm->appl.ptr % pcm->buffer_size;

appears to have pcm->buffer_size == 0. What's the correct approach in
handling this corner case?

Thanks,
Dan
