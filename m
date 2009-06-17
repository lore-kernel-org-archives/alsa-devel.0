From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: sound device is buzy to run pcm.c
Date: Tue, 16 Jun 2009 22:44:31 -0400
Message-ID: <75b66ecd0906161944q40f471fdiae23c3290c866e85@mail.gmail.com>
References: <fa40cc720906142011s5c2547e9r33a484a554a89fae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D506243F7
	for <Alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 04:44:32 +0200 (CEST)
Received: by gxk17 with SMTP id 17so76869gxk.8
	for <Alsa-devel@alsa-project.org>; Tue, 16 Jun 2009 19:44:31 -0700 (PDT)
In-Reply-To: <fa40cc720906142011s5c2547e9r33a484a554a89fae@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guilherme Raymo Longo <grlongo.ireland@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 14, 2009 at 11:11 PM, Guilherme Raymo
Longo<grlongo.ireland@gmail.com> wrote:
> I tried to check if the device is really buzy:
>
> root@lap:/home/guilherme/Experimentos# lsof |grep snd
> lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system */
> home/guilherme/*.gvfs
> =A0 =A0 Output information may be incomplete.
> esd =A0 =A0 =A0 5433 =A0guilherme =A0mem =A0 =A0 =A0 CHR =A0 =A0 116,16 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06947
> /dev/snd/pcmC0D0p
> esd =A0 =A0 =A0 5433 =A0guilherme =A0 =A05r =A0 =A0 =A0 =A0 =A0CHR =A0 =
=A0 116,33 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06787
> /dev/snd/timer
> esd =A0 =A0 =A0 5433 =A0guilherme =A0 =A06w =A0 =A0 =A0 =A0CHR =A0 =A0 11=
6,16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06947
> /dev/snd/pcmC0D0p
> esd =A0 =A0 =A0 5433 =A0guilherme =A0 =A07r =A0 =A0 =A0 =A0 CHR =A0 =A0 =
=A0116,0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06987
> /dev/snd/controlC0
>
> and it seems to be ok.

Of course it's busy, esd has it open.

Lee
