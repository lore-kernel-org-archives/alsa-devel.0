From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: SND-SOC - how to test drivers ?
Date: Tue, 23 Nov 2010 09:07:49 +0900
Message-ID: <AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
References: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id DCE6F243FB
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 01:07:49 +0100 (CET)
Received: by fxm10 with SMTP id 10so485848fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 16:07:49 -0800 (PST)
In-Reply-To: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vaclav Peroutka <vaclavpe@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 23, 2010 at 6:24 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:

> What I want is to make some testbench driver and an application which
> can set switching matrix registers through IOCTL. In MAX9880 I want to
> preset microphone path to output and switch matrix until I hear my
> voice from microphone in speaker or headphones. Or, is there any
> better method how to do that ?
>
> AFAIK there is no alsamixer application for Android. What do you use
> for path and gain settings in this case ?

How about first making the driver work with some, non-Android, rootfs
that has alsa-utils ?
