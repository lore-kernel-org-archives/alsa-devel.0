From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Sun, 26 Apr 2009 14:14:44 -0400
Message-ID: <9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E4B9F2439E
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 20:14:45 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3790545qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 11:14:44 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 12:43 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Sun, 26 Apr 2009, Jon Smirl wrote:
>
>> Here's the code computing the mpc5200 dma pointer. Could you please
>> take a look at it and let me know what it is doing wrong.
>
> I think that the culprit of your problems is that your code expects that
> buffer_size / period_size is an integer value (whole period is placed ins=
ide
> ring buffer). But if you do not instruct the high level code of ALSA in
> open() callback by calling snd_pcm_hw_constraint_integer(runtime,
> SNDRV_PCM_HW_PARAM_PERIODS) to do so - see other drivers - then period mi=
ght
> be also placed across the buffer_size boundary - which appearently makes
> your current problems.
>
> I think that bcom_submit_next_buffer() expects continuous memory (thus wh=
ole
> period), right?

Yes, it wants continuous memory. I added SNDRV_PCM_HW_PARAM_PERIODS
and things are working better.
That was a better solution than breaking up operations into multiple
DMA requests.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
