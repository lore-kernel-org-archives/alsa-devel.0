From: "John Kacur" <jkacur@gmail.com>
Subject: No pcm device?
Date: Mon, 20 Oct 2008 14:34:39 +0200
Message-ID: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id B7373103806
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 14:34:57 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so985135waf.16
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 05:34:39 -0700 (PDT)
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
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

I'm not sure if the hardware I have makes this problem simple for me,
or difficult, because it seems to differ from other ASoC code.
Basically, I have a i2s as transport, connected to max5556 driving the
output. (and a few other chips related to amplification and muting)
There is however no sound card, thus no PCM device. Now the question
is how to proceed? In other words what kind of minimal PCM layer do I
need if any?

Thanks
