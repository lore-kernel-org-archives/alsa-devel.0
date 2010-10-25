From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: MIDI support for hda-intel
Date: Sun, 24 Oct 2010 20:59:25 -0400
Message-ID: <AANLkTimJH2y6RunNeK-FCpS9QVgwxppSRQfA8yX_pG7u@mail.gmail.com>
References: <AANLkTin9i1y_yAwq748Hcf4Y9Kf+rUohTqgq5XFSQwCN@mail.gmail.com>
	<s5hbp6janh1.wl%tiwai@suse.de>
	<AANLkTikvm3MtgOoMY8egP5LJR+PGa7NUXS5kYAW3ZtyD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C0E81037EA
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 02:59:26 +0200 (CEST)
Received: by wwb18 with SMTP id 18so2817224wwb.20
	for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2010 17:59:25 -0700 (PDT)
In-Reply-To: <AANLkTikvm3MtgOoMY8egP5LJR+PGa7NUXS5kYAW3ZtyD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nick Lloyd <ultrageek.lloyd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You'll need to use a softsynth, e.g., fluidsynth, timidity, and be aware
that, depending on the desktop distro that you use, you may encounter races
with other apps attempting to access the device.
