From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC] Remove Alchemy OSS drivers?
Date: Fri, 20 May 2011 08:51:37 +0200
Message-ID: <BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
References: <20110519231911.GB10628@linux-mips.org>
	<s5hoc2x7tsr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 52E7D103836
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 08:51:38 +0200 (CEST)
Received: by yib2 with SMTP id 2so1344019yib.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 23:51:37 -0700 (PDT)
In-Reply-To: <s5hoc2x7tsr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Namhyung Kim <namhyung@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, lkml@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 20 May 2011 00:19:12 +0100,
> Ralf Baechle wrote:
>>
>> OSS has very little if any useful life in it left for MIPS, at least from
>> my perspective. =A0So I propose to remove the Au1550 driver - there is an
>> ALSA replacement for it available.
>
> Even two variants available: one in ASoC driver and one in old ALSA
> driver.

The current ASoC code can replace sound/oss/au1550_ac97.c,
but sound/mips/au1x00.c is for different (earlier) chips.  I wrote an ASoC
variant of this a long time ago, but I can't test it on real hardware.

Manuel
