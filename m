From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: Cross compiling alsa-lib (again)
Date: Mon, 7 Jan 2008 19:54:01 +0000
Message-ID: <8b67d60801071154n1d9b46d0qcb681b19dc37a295@mail.gmail.com>
References: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
	<1199702857.17059.1229845735@webmail.messagingengine.com>
	<8b67d60801070805x5755db9cva66b2187f1f236a0@mail.gmail.com>
	<75b66ecd0801070829v7d138304l74d4d47a13a1b424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 96989249C4
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 20:54:03 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so4921594rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Jan 2008 11:54:01 -0800 (PST)
In-Reply-To: <75b66ecd0801070829v7d138304l74d4d47a13a1b424@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/01/2008, Lee Revell <rlrevell@joe-job.com> wrote:
> On Jan 7, 2008 11:05 AM, Adrian McMenamin <lkmladrian@gmail.com> wrote:
> > Well this is from the driver:
> >
> >  .info = (SNDRV_PCM_INFO_NONINTERLEAVED),
> >
> > Is it required to set SNDRV_PCM_INFO_INTERLEAVED ? Even if the
> > hardware doesn't support it? Surely alsa-lib is supposed to handle the
> > conversion in any case?
>
> It should if you use aplay -D plughw:0,0 file.wav.
>
> Lee
>

Well, get this now:


$ aplay -D plughw:0,0 /aine-email.wav
Playing WAVE '/aine-email.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for 'plughw:0,0'
aplay: set_params:895: Access type not available
