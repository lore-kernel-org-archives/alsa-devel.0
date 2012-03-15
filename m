From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: sound: BUG: unable to handle kernel irq event stamp: 2013419
Date: Thu, 15 Mar 2012 17:50:55 +0200
Message-ID: <CA+1xoqfR6K=Hw+kWMUncXQj74EYDOj6f4gAnJzetCHjv2s+xow@mail.gmail.com>
References: <CA+1xoqfKE2u7mm=o507TvoFw8oqtKq8RRaJ5jU4c=J-GAH0APw@mail.gmail.com>
 <s5h4ntpx4hk.wl%tiwai@suse.de> <CA+1xoqeL96L9SvtQ2ckXez-Kye4D9qRhuREd9Bq97wGU468R3w@mail.gmail.com>
 <s5hy5r1vpch.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy5r1vpch.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, lucas.demarchi@profusion.mobi, Thomas Gleixner <tglx@linutronix.de>, Dave Jones <davej@redhat.com>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 15, 2012 at 5:46 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 15 Mar 2012 17:36:44 +0200,
> Sasha Levin wrote:
>>
>> On Thu, Mar 15, 2012 at 5:34 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > The bug seems coming from the old OSS driver. =A0Do you enable any=
 OSS
>> > drivers?
>>
>> They're most likely compiled in (kernel is pretty close to a 'make
>> allyesconfig'), but I haven't done anything in particular to start
>> them.
>
> What does trinity at all?

It's a syscall fuzzer which can be found here:
codemonkey.org.uk/projects/trinity/trinity.git
