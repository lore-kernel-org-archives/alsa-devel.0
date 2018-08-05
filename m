From: Lukas Wunner <lukas@wunner.de>
Subject: Re: CS8409 Macbook Pro 2016 2017
Date: Sun, 5 Aug 2018 21:32:04 +0200
Message-ID: <20180805193204.GA16304@wunner.de>
References: <CALbf9MzcxBqkBP4mbUKht72Ga6VnTubeiHcTr2joEf7i-enxFQ@mail.gmail.com>
 <s5h7el6vd91.wl-tiwai@suse.de>
 <CALbf9Mw=Y5ddFZDZQ4_mfYCHxKb9XFHN3v5ge0JaTca7NLMM7A@mail.gmail.com>
 <s5hzhy2t7ww.wl-tiwai@suse.de>
 <CALbf9MwN4pEk26R9c2-UMxzvLXQ3OOBTcqgdSvXeFb-dw7-Wnw@mail.gmail.com>
 <s5hwot6t5qz.wl-tiwai@suse.de>
 <CALbf9MzYvcz+d0HKmvc60WhTHVpiuTK8O66qNH3Xcuo5j3uU9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [83.223.95.100])
 by alsa0.perex.cz (Postfix) with ESMTP id E1C1A2673A0
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2018 21:32:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALbf9MzYvcz+d0HKmvc60WhTHVpiuTK8O66qNH3Xcuo5j3uU9Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Ulricht <david.ulricht434@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Leif Liddy <leif.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 04, 2018 at 11:30:29PM +0300, David Ulricht wrote:
> What am I doing wrong ?  Is the below script correct for testing the GPIOs ?
> for x in range(0,256):
>     mhex=("0x%0.2X" % x)
>     os.system("hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK "+mhex)
>     os.system("hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIRECTION "+mhex)
>     os.system("hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA "+mhex)
> I think its not correct gpio_direction i guess could be only 0 or 1?
> What happens when I pass a different value to data than 0/1 ? this should
> also not be correct.
> I guess 0x01 is the NID value is it okay to use 0x01 only or I have to pass
> other values to it also ?

The speakers are driven by digital amplifiers MAX98706.  The MBP13,3
has four (treble/bass x left/right).  They're attached via i2c to
GPIO 6 (SCL) and 7 (SDA) of the CS8409 HDA bridge.  It's possible
that you need to initialize the amps via i2c, in that case using the
GPIOs in bitbanging mode is wrong.

Leif Liddy has been looking into this as well (+cc):
https://bugzilla.kernel.org/show_bug.cgi?id=110561

Lukas
