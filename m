From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: how to disable mmap and allow .copy function to be
	called
Date: Thu, 24 Apr 2008 12:11:04 +0530
Message-ID: <827ad74d0804232341q647c8561q6b426012cd83fea0@mail.gmail.com>
References: <827ad74d0804232129s4f52bbe3g2861acc6ddc778ef@mail.gmail.com>
	<48101958.4050304@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id C66B42445E
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 08:41:05 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so836766ana.80
	for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2008 23:41:04 -0700 (PDT)
In-Reply-To: <48101958.4050304@audioscience.com>
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
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you. I tried that but on starting a playback it gives me an error that
the device is in use and does not playback. Should i be enabling anything
else for my .copy function to be invoked and successful playback to happen?

On Thu, Apr 24, 2008 at 10:53 AM, Eliot Blennerhassett <
linux@audioscience.com> wrote:

> Harsha priya gupta wrote:
> > Hi,
> >
> > Can anyone help me - I need to modify an existing driver such that a new
> > .copy function is invoked. how to make sure that mmap is diabled?
> >
>
> Remove SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID
>
> from the struct snd_pcm_hardware.info initialisation.
>
> --
> Eliot
>
>
>
>
>


-- 
-Harsha
