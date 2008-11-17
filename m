From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Re: snd-usb-audio: minimum period time as module
	option?
Date: Mon, 17 Nov 2008 20:23:06 +0100
Message-ID: <d9690f190811171123s1c9bbd00y73dd1cdc87f1ce58@mail.gmail.com>
References: <d9690f190811171121t20efc7c6v785bd827f068187c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 04F121037E3
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 20:23:07 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so1836331ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 11:23:06 -0800 (PST)
In-Reply-To: <d9690f190811171121t20efc7c6v785bd827f068187c@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2008 at 8:21 PM, Klaus Schulz <kls.schlz@googlemail.com>wrote:

> Hi folks (probably Clemens).
>
> Would  it be possible to to introduce a module-option variable to
> snd-usb-audio, so that it is possible to switch
> minimum period  from outside
>
> usbaudio.c
>
>     /* set the period time minimum 1ms */
>     /* FIXME: high-speed mode allows 125us minimum period, but many parts
>      * in the current code assume the 1ms period.
>      */
>     snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
>                      1000 * MIN_PACKS_URB,
>                      /*(nrpacks * MAX_URBS) * 1000*/ UINT_MAX);
>
>
>
> With 125us my EMU USB 0404 and also my PCM2707 devices do sound better.
>
> THX
> \Klaus
>
