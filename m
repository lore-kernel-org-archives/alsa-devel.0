From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: XRUN handling
Date: Tue, 6 Jul 2010 17:16:42 +0100
Message-ID: <AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id C067A24524
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 18:16:44 +0200 (CEST)
Received: by fxm15 with SMTP id 15so4941034fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2010 09:16:43 -0700 (PDT)
In-Reply-To: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: melwyn lobo <linux.melwyn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6 July 2010 06:03, melwyn lobo <linux.melwyn@gmail.com> wrote:
> Hi all,
> I have noticed when an Xrun occurs, the bytes between the hw_ptr and
> appl_ptr are not copied when both hw and appl pointers are reset in
> snd_pcm_prepare().
>
> Is my analysis correct? If so how do we ensure correct behaviour ie
> byte accuracy after Xrun.
>

When an Xrun occurs, all bets are off. You should reset the sound card
buffers and start again.
The best thing to do is try to track down why the Xrun occurs in the
first place and stop it happening.
It most likely occurs because some other device is keeping the CPU
from servicing the interrupt correctly.
Normally graphics card drivers, hard disk drivers or file system code
causes this problem.
Look at low latency and real time patches for the Linux kernel.

Kind Regards

James
