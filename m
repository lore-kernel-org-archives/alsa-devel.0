From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALC883 features
Date: Sat, 30 May 2009 01:41:55 -0400
Message-ID: <75b66ecd0905292241p44573981q5300da31b5a65c48@mail.gmail.com>
References: <6d18452c0905280830q6d2b0477ve5a549aadaf583ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F52D247F1
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 07:41:56 +0200 (CEST)
Received: by ewy23 with SMTP id 23so6967230ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2009 22:41:55 -0700 (PDT)
In-Reply-To: <6d18452c0905280830q6d2b0477ve5a549aadaf583ad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Leies <michael.leies@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2009 at 11:30 AM, Michael Leies
<michael.leies@googlemail.com> wrote:
> I just bought a new computer from Dell with a Realtek ALC1200 (883?).
> =A0After messing with alsa configurations and looking into the driver
> code a bit, I noted that a few features i'd like don't seem to be
> supported by the current driver.
>
> 1) Use of all 10 channels, only 8 are wired out to the 7.1 pcm device
> (forgive me if i lack the proper terminology for the moment). =A0From
> the 883 datasheet, and comments in 1.0.20 code it seems the last 2
> channels could be wired out as a separate PCM device.

How did you conclude that the ALC883 specs apply to the ALC1200?
Every source I can find says the ALC1200 is an 8 channel codec.
Unfortunately there's no Realtek doc for the ALC1200 so this is based
on various reviews and forum posts...

Lee
