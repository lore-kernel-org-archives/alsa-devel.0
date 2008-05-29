From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: my ALS drv gives DMA underrun
Date: Wed, 28 May 2008 20:10:53 -0400
Message-ID: <75b66ecd0805281710g5852332dw230d30d5995dd279@mail.gmail.com>
References: <483D77A5.5020203@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DFF424785
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 02:10:55 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2956669rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 17:10:54 -0700 (PDT)
In-Reply-To: <483D77A5.5020203@aimvalley.nl>
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
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 28, 2008 at 11:17 AM, Norbert van Bolhuis
<nvbolhuis@aimvalley.nl> wrote:
> probably this question is asked many times.
>
> Anyway, I hope the experts are willing to help me here.
> I simply don't know how to avoid the DMA overrun that I'm facing
> when playing a tone.

Not calling snd_pcm_period_elapsed at the right time would cause the
behavior you see.    This function wakes up any apps that are waiting
to send data to the sound device.

Where can I find the source code for your driver?

Lee
