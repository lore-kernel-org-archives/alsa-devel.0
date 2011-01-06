From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: Do I have to use plugin?
Date: Thu, 6 Jan 2011 10:31:49 +0900
Message-ID: <AANLkTi=vaxT1yvSFRKQaKJhC=gWEhcnNH7h86hxFwGSr@mail.gmail.com>
References: <AANLkTimBooxhWj7AYRSjS7zkMRd28y2wWGeWfaPmhs8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B0261103827
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 02:31:49 +0100 (CET)
Received: by bwz10 with SMTP id 10so9162035bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 17:31:49 -0800 (PST)
In-Reply-To: <AANLkTimBooxhWj7AYRSjS7zkMRd28y2wWGeWfaPmhs8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 6, 2011 at 3:43 AM, Radivoje Jovanovic
<radivojejovanovic@gmail.com> wrote:
> Hi,
> I have a system that is slow and cannot support overhead for re-sampling
> input streams. The codec on the system supports all rates from 8K-48K and it
> is continuous so pretty much any rate should work no problem. However, I
> noticed that when I play a song that has weird rate that is not specified in
> the constraint list aplay would come back saying that it cannot set hardware
> parameters. If I play the same song using the virtual device through "plug"
> plugin the thing works no problem. I guess that alsa-lib re-samples the data
> to rate specified in the virtual device. Is there any way for me to force
> alsa to forward any rate to the hardware driver?

Perhaps you need to add SNDRV_PCM_RATE_CONTINUOUS/KNOT to the rates list
in both the CPU and the CODEC drivers.
