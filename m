From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: snd_pcm_avail_update() needed before snd_pcm_delay()
	with hda-intel
Date: Fri, 6 Jun 2008 21:54:22 +0200
Message-ID: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E4FF1037FA
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 21:54:24 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so975563wxd.23
	for <alsa-devel@alsa-project.org>; Fri, 06 Jun 2008 12:54:23 -0700 (PDT)
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

snd_pcm_avail_update() documentation says: "Using of this function is
useless for the standard read/write operations. Use it only for mmap
access. See to snd_pcm_delay."

snd_pcm_delay() documentation says: "Note this function does not
update the actual r/w pointer for applications. The function
snd_pcm_avail_update() have to be called before any begin+commit
operation."

My english is far from perfect, and so the problem can be that I
missunderstood the docs but:
1- "Using of this function"? Should not be "Use of this function"?
2- Is snd_pcm_avail_update() really useless when not using mmap?
I have a SB Live! where snd_pcm_delay() always returns the correct
value, without any need for snd_pcm_avail_update(). But the same code
in the same machine with an hda-intel AD1988 needs a call to
snd_pcm_avail_update() before snd_pcm_delay() to give the correct
result. Without it snd_pcm_delay() always returns the value that *was*
correct in the last snd_pcm_writei() call.

So should the "application frame position" be always updated, or only
in read/write operations? In the first case AD1988 fails, in the
second case perhaps SB Live! is making too mucho work ;-)
