From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Support for floating point controls?
Date: Mon, 1 Feb 2010 18:13:47 +0000
Message-ID: <ad2655cb1002011013m15b6c59atcafa9210078e1366@mail.gmail.com>
References: <4B60C841.9010306@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 8707C243FC
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 19:13:48 +0100 (CET)
Received: by fxm4 with SMTP id 4so819167fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 10:13:48 -0800 (PST)
In-Reply-To: <4B60C841.9010306@audioscience.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Which hardware supports these 32 bit float controls?


On 27 January 2010 23:12, Eliot Blennerhassett <linux@audioscience.com> wrote:
> Greetings,
>
> some of our products now have control paramters that are 32 bit floating
> point values.
>
> I wonder if a patch implementing float ctl elements would be accepted?
> Note that the floats are not manipulated in the kernel at all, the
> values are just passed through from the hardware to userspace (?)
>
