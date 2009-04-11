From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: oss emul: powerbook5,3 microphone to mono
Date: Fri, 10 Apr 2009 20:55:47 -0400
Message-ID: <75b66ecd0904101755n4261340ex1aebf4ae2120b27c@mail.gmail.com>
References: <49DE69D6.6050305@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F53B2434D
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Apr 2009 02:55:48 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so998627ywr.2
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2009 17:55:47 -0700 (PDT)
In-Reply-To: <49DE69D6.6050305@earthlink.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Robert T. Drury" <rtdrury@earthlink.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 9, 2009 at 5:34 PM, Robert T. Drury <rtdrury@earthlink.net> wro=
te:
> On machine powerbook5,3 the built-in microphone is attached to
> the right channel of the sound chip. =A0In the alsa oss emulation
> in linux-2.6.23.9 (alsa-*-1.0.12) the plugin layer copies the
> left input channel to a one-channel buffer when =A0calling ioctl
> SNDCTL_DSP_CHANNELS with one channel. =A0So no mic to mono on the
> powerbook5,3.
>
> In the kernel source: linux-2.6.23.9/sound/core/oss/pcm_plugin.c:
>
> The function snd_pcm_plug_read_transfer copies from the two
> channel hardware input buffer to the one channel user space
> buffer. =A0 The left source channel appears to be selected for
> copy in function snd_pcm_plug_format_plugins. =A0One approach
> is to query line/mic input there for powerbook5,3 and select
> right channel source for copy. =A0Any ideas?

Try a recent ALSA.  The latest is 1.0.19.  1.0.12 is way too old to debug.

Lee
