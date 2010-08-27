From: VDR User <user.vdr@gmail.com>
Subject: Re: xine AC3 dropout problem - Please help!
Date: Fri, 27 Aug 2010 13:03:22 -0700
Message-ID: <AANLkTimQZz0k-MMWw_rT4v-GwjS7oZy8-8GRLSetf-nF@mail.gmail.com>
References: <AANLkTim_nj3t6FUY1Qnd=3AXkajELkAGzswOHN3ox3xE@mail.gmail.com>
	<alpine.LNX.2.00.1008271926500.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CC27D1038B6
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 22:03:23 +0200 (CEST)
Received: by gxk28 with SMTP id 28so1411647gxk.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 13:03:22 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008271926500.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 27, 2010 at 10:33 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Fri, 27 Aug 2010, VDR User wrote:
>
>> occurs in xine. =A0The error I see in the xine log when the dropout
>> occurs is: pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed
>> (-32).
>
> -32 means -EPIPE - underrun has occured. It means that xine does not deli=
ver
> samples in time to the driver for some reason. Because mplayer works, it
> does not seem like a general ALSA issue. I would ask xine developers for
> further debugging of this issue (compare the audio write calls with the
> realtime clock).
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0Jaroslav


Hi Jaroslav.  Thanks for your reply.  It seems I mistakeningly sent
this to the alsa-dev mailing list instead of xine-dev for which it was
intended.  Sorry about that, but thanks for the comments!

Best regards,
Derek
