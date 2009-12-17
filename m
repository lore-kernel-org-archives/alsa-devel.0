From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: 2.6.32-gitX: oops in ac97 codec registration
Date: Thu, 17 Dec 2009 17:31:14 +0100
Message-ID: <f861ec6f0912170831r16b98515u7afdc68fcbb64fcd@mail.gmail.com>
References: <f861ec6f0912170040m57874014s7b1a6bb3b863c0f1@mail.gmail.com>
	<20091217105559.GC20667@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 356D010380F
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 17:31:23 +0100 (CET)
Received: by bwz9 with SMTP id 9so3403303bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 08:31:22 -0800 (PST)
In-Reply-To: <20091217105559.GC20667@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Dec 17, 2009 at 11:56 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 17, 2009 at 09:40:50AM +0100, Manuel Lauss wrote:
>
>> current 2.6.32-git spits out the following oops when I load my machine
>
> Do you mean 2.6.32 or 2.6.33?

Linus' latest (so 2.6.33-rc)


>> Oops is inside snd_ac97_dev_add_pdata() call: seems ac97->dev is NULL.
>
>> I'm not entirely sure that this isn't somehow the fault of my machine dr=
iver;
>> has the procedure to register the asoc device changed since 2.6.32?
>
> The generic AC97 bodge code is broken. =A0Again. =A0I've not checked the
> ordering requirements here but reversing the order of snd_soc_new_pcms()
> and snd_ac97_bus() in ac97_soc_probe() might do the trick.

It's not that easy; seems something else is fishy.  I even get an oops with
I2S.  I'll try to find out what's going on (the same code works on
vanilla 2.6.32
though).

Manuel
