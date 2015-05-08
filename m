From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: codecs-ac97: Remove rate constraints
Date: Sat, 09 May 2015 01:14:47 +0200
Message-ID: <554D4367.6070500@maciej.szmigiero.name>
References: <554D27A6.4040602@maciej.szmigiero.name>
 <CAOMZO5A=M2oW47r8_MPrxkd9z6kDj6FG68fVAdKAzngPX0mn=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AADD260587
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 01:14:57 +0200 (CEST)
In-Reply-To: <CAOMZO5A=M2oW47r8_MPrxkd9z6kDj6FG68fVAdKAzngPX0mn=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Brian Austin <brian.austin@cirrus.com>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

W dniu 08.05.2015 23:32, Fabio Estevam pisze:
> On Fri, May 8, 2015 at 6:16 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> Remove rate constraints from generic ASoC AC'97 CODEC and make
>> it selectable in config.
> 
> Shouldn't this be split in two patches?

I've submitted it as one patch because they are two trivial changes
to make the generic ASoC AC'97 CODEC usable for me outside existing
platform files.

But naturally, I can split them and submit them separately
if that would be better.

>> Supported rates should be detected and constrained anyway by
>> AC'97 generic code - was tested with VT1613 CODEC and iMX6 SSI
>> controller.
> 
> Nice, I would like to test this on a Udoo board. Care to share the dts
> changes? (I know this is off topic for this list ;-) Apart from the
> dts changes: are there still missing patches in linux-next to make
> audio work in Udoo?

I currently have audio running on this board at kernel based on
vanilla 3.19 and porting required changes part-by-part to linux-next.

Changes required on vanilla 3.19 to have it working are:
* AC'97 audio support needs to be added to fsl-asoc-card,

* AC'97 CODEC platform device needs to be instantiated in fsl_ssi,

* IPG clock needs to be enabled in fsl_ssi AC'97 mode,
so AC'97 regs can be accessed,

* Few small fixes for AC'97 mode in fsl_ssi (missing switch label
for format, missing  fsl_ssi_dai_probe entry in fsl_ssi_ac97_dai,
etc.).

There also is a problem with this CODEC that it seems to pull samples
for S/PDIF output from time to time even if S/PDIF output is disabled.

By default this requests samples in AC'97 slots 10/11 via SLOTREQ,
which in turn causes SSI to enable these slots in SACCST register
and start sending half of the sound samples there.

The end result is that audio suddenly starts to play two times
too fast.

Currently, I have a workaround of setting S/PDIF slot assignment
in CODEC to first front pair so at least it doesn't affect
playback rate.

If you like to have these changes or DT file diff then naturally
I can share them, just they aren't production-quality as of now.

>> This way this driver can be used for platforms which don't need
>> specialized AC'97 CODEC drivers while at the same avoiding
>> code duplication from implementing equivalent functionality in
>> a controller driver.
>>
>> Resending due to no response received.
> 
> No need to put this in the commit log.
>
> Thanks

Thanks for looking into patch and best regards,
Maciej Szmigiero
