From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: intel8x0 - copy function
Date: Fri, 25 Apr 2008 13:24:21 +0530
Message-ID: <827ad74d0804250054k43142a7bl55b66f64074dd186@mail.gmail.com>
References: <827ad74d0804242342g68415172tcb43acb92a8cf9f8@mail.gmail.com>
	<s5h7iem4dqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BFA024718
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 09:54:22 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so973076ana.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 00:54:21 -0700 (PDT)
In-Reply-To: <s5h7iem4dqs.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

aplay works. But real player still gives me the error. What is the reason?

On Fri, Apr 25, 2008 at 12:34 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 25 Apr 2008 12:12:36 +0530,
> Harsha priya gupta wrote:
> >
> > Hi,
> >
> > I am using Intel8x0 driver for my sound card.  During data transfer from
> > user to driver, I am trying to collect the buffer. I have implemented
> .copy
> > function and also disabled the mmap.
> >
> > If I disable the mmap in .info structure, i get an error that the device
> is
> > in use. If i try getting the debug messages; It fails in
> > snd_pcm_common_ioctl1 for  SNDRV_PCM_IOCTL_HW_REFINE.
> >
> > Can anyone please guide me on to the right path of implementing what I
> want
> > to do.
>
> Does the error occur even if you access via "hw:0", such as,
>        % aplay -Dhw:0 foo.wav
>
> ??  If yes, there is some incosistency between the hardware
> configuration and the implementation...
>
>
> Takashi
>



-- 
-Harsha
