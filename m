From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2 v2] Improve hw_params documentation
Date: Sun, 27 Nov 2011 12:31:38 +0800
Message-ID: <CAN8cciahMcYN6NOzLyxs28x0Vgc_Yd3WNGLTuAmJbTykSsVQuA@mail.gmail.com>
References: <20111123150849.GD1570@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 07B4E247FC
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 05:31:39 +0100 (CET)
Received: by bkat8 with SMTP id t8so5691194bka.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2011 20:31:38 -0800 (PST)
In-Reply-To: <20111123150849.GD1570@foghorn.codeweavers.com>
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
List-Id: alsa-devel@alsa-project.org

2011/11/23 Andrew Eikum <aeikum@codeweavers.com>:
> ---
>
> Tweaked the snd_pcm_hw_params_t description to reflect how ALSA is
> intended to work, even if that's not how some plugins (pulse)
> currently work due to bugs.
>
> =A0include/pcm.h | =A0 17 ++++++++++++++++-
> =A0src/pcm/pcm.c | =A0 10 +++++++++-
> =A02 files changed, 25 insertions(+), 2 deletions(-)
>
>

But Tick time is already deprecated.

Some sound cards such au88x0 may return error when there is no enough SRC


and there is another error for plughw with snd-hda-intel


./alsa_period_count plughw:1
min periods 0  dir 1
max periods 4294967295 dir 0
min_buffer_frames: 10240
set max buffer size: 10240
snd_pcm_hw_params: -22
[raymond@localhost ~]$ export LIBASOUND_DEBUG=3D1
[raymond@localhost ~]$ ./alsa_period_count plughw:1
min periods 0  dir 1
max periods 4294967295 dir 0
min_buffer_frames: 10240
set max buffer size: 10240
ALSA ERROR hw_params: set (RATE)
           value =3D 4000 : Invalid argument
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: [16 32]
FRAME_BITS: [32 448]
CHANNELS: [2 14]
RATE: [8000 192000]
PERIOD_TIME: (15 1024000]
PERIOD_SIZE: [3 8192]
PERIOD_BYTES: [128 458752]
PERIODS: [2 32]
BUFFER_TIME: (31 2048000]
BUFFER_SIZE: [6 16384]
BUFFER_BYTES: [128 65536]
TICK_TIME: ALL
ALSA ERROR hw_params: set (RATE)
           value =3D 4000 : Invalid argument
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: [16 32]
FRAME_BITS: [32 448]
CHANNELS: [2 14]
RATE: [8000 192000]
PERIOD_TIME: (15 1024000]
PERIOD_SIZE: [3 8192]
PERIOD_BYTES: [128 458752]
PERIODS: [2 32]
BUFFER_TIME: (31 2048000]
BUFFER_SIZE: [6 16384]
BUFFER_BYTES: [128 65536]
TICK_TIME: ALL
snd_pcm_hw_params: -22
