From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: SND-SOC - how to test drivers ?
Date: Wed, 1 Dec 2010 08:34:48 +0900
Message-ID: <AANLkTikBz5t-hUxQYfF6Q_hwyO50hxgxfhhF-FaoAjT4@mail.gmail.com>
References: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
	<AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
	<AANLkTi=SLNeQ5mEFKztB9cmDh3AUVz0fYOB6LGKzf6nL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F48F103988
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 00:34:49 +0100 (CET)
Received: by bwz8 with SMTP id 8so5756891bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:34:49 -0800 (PST)
In-Reply-To: <AANLkTi=SLNeQ5mEFKztB9cmDh3AUVz0fYOB6LGKzf6nL@mail.gmail.com>
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

On Wed, Dec 1, 2010 at 6:14 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:
> 2010/11/23 Jassi Brar <jassisinghbrar@gmail.com>:
>> On Tue, Nov 23, 2010 at 6:24 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:
>>
>> How about first making the driver work with some, non-Android, rootfs
>> that has alsa-utils ?
>>
>
> Hello, I did some progress, but not too much. I am getting "no
> soundcards found" even if I have /dev/snd and /proc/asound like below.
> What did I do wrong ?

Please make sure you use the same I2S device (indexed) in ASoC machine
driver as your board init file adds to the platform.
