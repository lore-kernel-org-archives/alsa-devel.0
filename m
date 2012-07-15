From: Daniel Mack <zonque@gmail.com>
Subject: Re: Status of USB audio class 2 drivers in ALSA
Date: Sun, 15 Jul 2012 23:43:32 +0200
Message-ID: <50033984.6050407@gmail.com>
References: <CAFi4vu-LeUyVg_wz_OkMVTrGbc-n1e6MKoJwo+iTHgbwD5s0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6503224375
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jul 2012 23:43:40 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so3220071bkc.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2012 14:43:40 -0700 (PDT)
In-Reply-To: <CAFi4vu-LeUyVg_wz_OkMVTrGbc-n1e6MKoJwo+iTHgbwD5s0zA@mail.gmail.com>
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

On 15.07.2012 23:03, Anand Joseph wrote:
> I am working on building a multi-channel USB audio device using the
> PIC32MX2 series with dual WM8731 audio codecs. The goal is a low cost
> 4 channel USB audio device. While this might not be the best
> combination for
> multi-channel audio, I do not have a better solution as the XMOS
> series is not easily available in India. I would like to know the
> status of USB audio class 2 support in ALSA and is there anyway I can
> contribute. I did go through the USB specifications for audio class 2
> devices, but an idea of the implementation in ALSA would help in
> writing the firmware.

UAC2 is mostly supported in ALSA since a while. Things that are missing
are exotic features like complex clock infrastructure handling and some
mixer extension units that haven't been observed in the wild yet.

In any case, the support that is there already is more than enough to
support a simple streaming device like the one you have in mind.

Let us know how your project goes and if you encounter any problems with
the drivers.


Daniel
