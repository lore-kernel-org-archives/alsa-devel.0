From: Adam Richter <adam_richter2004@yahoo.com>
Subject: Re: Possible fix for snd-hda-intel model=no-jd failing
	since ~linux-3.9-rc1
Date: Thu, 11 Sep 2014 21:40:43 -0700
Message-ID: <1410496843.75569.YahooMailBasic@web160605.mail.bf1.yahoo.com>
References: <1410496225.69683.YahooMailBasic@web160606.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm5-vm0.bullet.mail.bf1.yahoo.com
 (nm5-vm0.bullet.mail.bf1.yahoo.com [98.139.213.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EFAA2656E2
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 06:40:44 +0200 (CEST)
In-Reply-To: <1410496225.69683.YahooMailBasic@web160606.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi, again, Takashi.

A few minute ago, I wrote a side comment that you should ignore, which was =
the following:

>Also, by the way, it appears that linux-3.17-rc4's Intel "high defintiion =
audio"
> driver, regardless of whether this patch is applied, no
> longer shows Linux input subsystem devices for analog audio
> jack sense, although it does provide such a device for HDMI
> jack sense.=A0 [...]

In Linux 3.17-rc4, reloading the snd-hda-intel module without "model=3Dno-j=
d" results in those input devices being created.  So, it is not a bug.  In =
fact, I think is completely correct and an improvement that mode=3Dno-jd no=
w causes the jack sense Linux input layer devices not to be created, which =
should make it easier for userspace to detect and adapt to this situation.

Sorry for the distraction.

Adam Richter
