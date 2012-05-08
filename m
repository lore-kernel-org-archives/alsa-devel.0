From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Fast Track Ultra latency and new streaming logic.
Date: Tue, 8 May 2012 18:07:36 +0100
Message-ID: <CAE-xCyPXAyf+F8uFug+OoCt2KCdOW+7OqH4wCp5K=Wp1kp-BgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D0E1010449C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 19:07:37 +0200 (CEST)
Received: by vbip1 with SMTP id p1so4192298vbi.38
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 10:07:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I can't seem to get below 512frames in flight (2 256sample frames or 4 128
> or 8 64's) without consistant overruns.

On my side, I can run 256 frames ; 3 periods, no xruns at all at 48kHz...
I haven't tried to push the driver more than that,

Aur=E9lien
