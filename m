From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Query regarding pointer callback
Date: Sat, 23 Jun 2007 04:12:01 +0530
Message-ID: <61445c750706221542x6673fe6fyf275bbe6c55f8b04@mail.gmail.com>
References: <61445c750706221538j414508e0hcf2b9eeff9fbd47b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 772F010380F
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2007 00:42:03 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so942981wag
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 15:42:02 -0700 (PDT)
In-Reply-To: <61445c750706221538j414508e0hcf2b9eeff9fbd47b@mail.gmail.com>
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

It is called from snd_pcm_lib_ioctl too. In SNDRV_PCM_IOCTL1_RESET case.

On 6/23/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi
>
> In Writing an ALSA driver, it is said that
> pointer callback is called usually from the buffer-update routine in
> the pcm middle layer, which is invoked when snd_pcm_period_elapsed()
> is called in the interrupt routine. Then the pcm middle layer updates
> the position and calculates the available space, and wakes up the
> sleeping poll threads, etc
>
> What are the other places from where pointer callback is called? If it
> is not called from any other routine then does it mean that interrupts
> are occuring?
>
