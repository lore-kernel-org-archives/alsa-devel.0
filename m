From: Vaclav Peroutka <vaclavpe@gmail.com>
Subject: Re: SND-SOC - how to test drivers ?
Date: Wed, 24 Nov 2010 21:42:33 +0100
Message-ID: <AANLkTinkr_15NjUxPafXAKNkJeKcRc_fhNWiON=pqn8s@mail.gmail.com>
References: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
	<AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A3044103971
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 21:42:35 +0100 (CET)
Received: by wwb13 with SMTP id 13so36442wwb.2
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 12:42:34 -0800 (PST)
In-Reply-To: <AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/11/23 Jassi Brar <jassisinghbrar@gmail.com>:
> On Tue, Nov 23, 2010 at 6:24 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:
>
>> What I want is to make some testbench driver and an application which
>> can set switching matrix registers through IOCTL. In MAX9880 I want to
>> preset microphone path to output and switch matrix until I hear my
>> voice from microphone in speaker or headphones. Or, is there any
>> better method how to do that ?
>>
>> AFAIK there is no alsamixer application for Android. What do you use
>> for path and gain settings in this case ?
>
> How about first making the driver work with some, non-Android, rootfs
> that has alsa-utils ?
>
I would maybe use ADB shell. Now I am trying to compile alsa-utils for
arm-linux but it needs ncurses library for alsamixer. Is there any
command-line replacement of alsamixer ?
