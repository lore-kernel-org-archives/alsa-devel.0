From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Asterisk 1.4.17 and alsa 1.0.19 dmix plugin problem.
Date: Mon, 20 Apr 2009 20:22:21 +0200
Message-ID: <359c5480904201122m7a45dbe8hd1f6b597dea57283@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 37F2A244ED
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 20:22:22 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so25002fge.21
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2009 11:22:21 -0700 (PDT)
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

Hi!
I'm sorry if this is an old issue but I did not found help in
archives/alsaweb/google and I'm new to alsa, so this report is what I
guessed reading sources and compiling test apps for about 2 days, and
the following assumptions may be completely wrong.

Asterisk has an alsa channel that works fine when using plughw:0,0
both for read and for writing, but if use plug:dmix/plug:dsnoop or
default with a dmix/dsnoop wrapper in /etc/asound.conf it does not
emit any sound. It uses select on poll fd descriptor to know if the
pcm is ready to be sent output samples.
The select will never return as it seems the dmix plugin is not able
to signal when is ready.
I noted that using snd_pcm_wait works well but cannot be used in
asterisk as it needs to select on two fd.
I guess that snd_pcm_wait with dmix check the shared memory and not
the fd descriptor.
So should poll/select be avoided completely in applications (as they
does not know if the default pcm is a dmix) and asterisk alsa channel
be rewritten or is there a workaround?

Best Regards

      Nicola
