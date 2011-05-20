From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC] Remove Alchemy OSS drivers?
Date: Fri, 20 May 2011 09:18:14 +0200
Message-ID: <BANLkTinp4wY3ZNxAc1PvCz1ujHQrG1wE2w@mail.gmail.com>
References: <20110519231911.GB10628@linux-mips.org>
	<s5hoc2x7tsr.wl%tiwai@suse.de>
	<BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
	<20110520071256.GA23902@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6ABA8103A94
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 09:18:16 +0200 (CEST)
Received: by gwj17 with SMTP id 17so1349167gwj.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 00:18:14 -0700 (PDT)
In-Reply-To: <20110520071256.GA23902@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Namhyung Kim <namhyung@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 9:12 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, May 20, 2011 at 08:51:37AM +0200, Manuel Lauss wrote:
>
>> On Fri, May 20, 2011 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Fri, 20 May 2011 00:19:12 +0100,
>> > Ralf Baechle wrote:
>> >>
>> >> OSS has very little if any useful life in it left for MIPS, at least =
from
>> >> my perspective. =A0So I propose to remove the Au1550 driver - there i=
s an
>> >> ALSA replacement for it available.
>> >
>> > Even two variants available: one in ASoC driver and one in old ALSA
>> > driver.
>>
>> The current ASoC code can replace sound/oss/au1550_ac97.c,
>> but sound/mips/au1x00.c is for different (earlier) chips. =A0I wrote an =
ASoC
>> variant of this a long time ago, but I can't test it on real hardware.
>
> My immediate interest is to kill off sounds/oss/ on MIPS because
> sound/oss/soundcard.c is fairly ISA centric and does not build for some
> some MIPS systems with only half-arsed ISA support, that is no DMA suppor=
t.
>
> Manuel, I got a DBAu1250 board here and maybe I can find a DBAu1500
> Zinfandel board under some dusty hardware pile; would that be suitable for
> testing your work?

Yes, the db1500 would be perfect.

Manuel
