From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: How to tell user level hardware not support a
	certain format in a certain sample rate
Date: Mon, 2 Mar 2009 22:04:04 +0800
Message-ID: <4e090d470903020604h27ce2ce8l47f996edc9764ada@mail.gmail.com>
References: <4e090d470902222302g16a99f5dq77d0d40f6cba855e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 99F28243B8
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 15:04:05 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so1997708rvf.32
	for <alsa-devel@alsa-project.org>; Mon, 02 Mar 2009 06:04:04 -0800 (PST)
In-Reply-To: <4e090d470902222302g16a99f5dq77d0d40f6cba855e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/2/23 Richard Zhao <linuxzsc@gmail.com>:
> Hi,
>
> runtime->hw.rates and runtime->hw.formats indicate the rate and
> formats hardware can support, so the user level plugins can
> auto-convert the audio data. But hardware may not support a certain
> combin of sample rate and format, and will cause hw_parm fail. In such
> case, plugin auto-convert will not work.
> How can I let userlevel know the failure conbin, so let auto-convert work?
>
> Thanks
> Richard
>

Anybody can do me a favor please?

Thanks
Richard
