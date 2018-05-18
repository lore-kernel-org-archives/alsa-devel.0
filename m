From: Melvin Vermeeren <mail@mel.vin>
Subject: Re: [PATCH] ALSA: dice: add stream format parameters
	for Mytek devices
Date: Fri, 18 May 2018 22:01:03 +0200
Message-ID: <2438583.1KDy1DEBS4@melvin-pc>
References: <20632004.ST2tKRhYS0@melvin-pc>
 <3d9fd8b0-d67e-0591-ed6d-8eec562ab58b@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1675848210186270522=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B705267282
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 22:01:06 +0200 (CEST)
In-Reply-To: <3d9fd8b0-d67e-0591-ed6d-8eec562ab58b@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

--===============1675848210186270522==
Content-Type: multipart/signed; boundary="nextPart9056532.X6Jb71ADgd"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9056532.X6Jb71ADgd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 18 May 2018 04:54:01 CEST Takashi Sakamoto wrote:
> Hi,
> 
> On May 18 2018 04:00, Melvin Vermeeren wrote:
> > Mytek manufactures some equipment with DICE-based firewire ports. These
> > devices contain old versions of DICE firmware which lacks detailed
> > stream format reporting for all sampling clock modes.
> > 
> > Building upon the recent work by Takashi Sakamoto, hard-coded parameters
> > are added for the Stereo 192 DSD-DAC. When the device vendor and model
> > match the coded parameters are copied into the stream format cache.
> > 
> > Signed-off-by: Melvin Vermeeren <mail@mel.vin>
> > -- SNIP --
> 
>  From me, some supplements. In Mytek website, we can get firmwares for
> some models with interfaces for IEEE 1394 bus.
> 
> * Professional:   https://mytekdigital.com/professional/support/
>    * Stereo192-DSD-DAC:
> https://mytekdigital.com/support_docs/Mytek_Stereo192DSD%20DAC_firmware.zip
>    * 8x192ADDA DIO FW:
> https://mytekdigital.com/download_library/DioFWDiceMini3001.bin
> * HiFi:   https://mytekdigital.com/hifi/support/
>    * Manhattan DAC (Original model):
> https://mytekdigital.com/support_docs/Mytek_ManhattanDAC_firmware_v1.1.1.zip
> * Stereo192-DSD-DAC:
> https://mytekdigital.com/support_docs/Mytek_Stereo192DSD%20DAC_firmware.zip
> 
> When executing strings(1) to these firmwares, we can see below line:
> 
> For Stereo192-DSD-DAC:
> ```
> * Mytek Stereo192DA on DICE Mini (TCD2210)               *
> ```
> 
> For original Manhattan DAC:
> ```
> * Mytek Stereo192DA on DICE Mini (TCD2210)               *
> ```
> (I note that the line includes different name.)
> 
> For 8x192ADDA DIO FW:
> ```
> * Mytek 8x192ADDA DioFW on DICE Mini (TCD2210)     *
> ```
> 
> It's reasonable that we judge TCD2210 (a.k.a. Dice mini) ASIC used for
> Mytek models. Old firmwares were not released for this ASIC, thus your
> patch comment is not proper. The reason for this patch is that this
> model doesn't support extended protocol, which I've addressed at a
> commit commit 58579c056c1c ('ALSA: dice: use extended protocol to detect
> available stream formats').

Thank you for the details, I hadn't looked into the hardware side of things 
with this depth. I had assumed that the lack of reporting would be due to old 
firmware like with other models.

> Furthermore, for 8x192ADDA DIO FW, the firmware includes below
> line:
> 
> ```
> * EAP is supported.                                      *
> ```
> 
> I believe ALSA Dice driver can detect stream formats correctly for
> this model. Thus, the rest of piece may be for original Manhattan DAC.

It could be that the Manhattan does support EAP, it is quite a bit newer than 
the Stereo 192 DSD-DAC. Though at the same time, a lot of the internals are 
the same as in the 192.

> I note that all of Dice based devices utilizes Embedded Configurable
> Operating System(eCos)[1], and these firmwares are designed for eCos.
> IMHO, the firmwares can be parsed by format of eCos but I have never
> attempted it,
> 
>  From my curious, can you drive your model with DSD samples? If so, what
> kind of software do you use?

With lintweaker's out-of-tree USB 2.0 driver[1] it works with DoP. Due to 
latency requirements and reliability I always run over firewire however. I did 
some basic attempts to get it working from userspace, but I think it is not 
possible with the current snd_dice.

As for the player, I believe there are several that support it. So far I have 
been using MPD, which has native DSD playback[2][3].

I did attempt something cheap to see what would happen:

#define AM824_IN_PCM_FORMAT_BITS       SNDRV_PCM_FMTBIT_S32
#define AM824_OUT_PCM_FORMAT_BITS      SNDRV_PCM_FMTBIT_S32

For these two, I appended "| SNDRV_PCM_FMTBIT_DSD_U32_LE" and some other 
variants. MPD then refuses to play because:

alsa_output: opened hw:DAC,0 type=HW
alsa_output: buffer: size=1792..4096 time=10158..23220
alsa_output: period: size=896..2048 time=5079..11610
alsa_output: default period_time = buffer_time/4 = 23219/4 = 5804
alsa_output: format=DSD_U32_LE (Direct Stream Digital, 4-byte (x32), little 
endian, oldest bits in MSB)
alsa_output: buffer_size=4096 period_size=1024
output: opened "mpd_alsa_out" (alsa) audio_format=dsd128:4
exception: Failed to convert for "mpd_alsa_out" (alsa)
exception: nested: PCM conversion from f to dsd is not implemented
output: Retrying without DSD
alsa_output: opened hw:DAC,0 type=HW
alsa_output: buffer: size=1920..4096 time=10000..21334
alsa_output: period: size=960..2048 time=5000..10667
alsa_output: default period_time = buffer_time/4 = 21333/4 = 5333
alsa_output: format=S32_LE (Signed 32 bit Little Endian)
alsa_output: buffer_size=4096 period_size=1024
output: opened "mpd_alsa_out" (alsa) audio_format=192000:32:4
libsamplerate: setting samplerate conversion ratio to 0.27
output: converting in=dsd128:2 -> f=dsd128:2 -> out=192000:32:4

I am pretty sure this happens because the DSD128 file is 2 channels, and MPD 
sees the output in 4 channels. It does exactly the same for DSD64. I am not 
sure how this should be handled since the channels are not actually for 4.0 
audio. Possibly need to expose it is a 2-channel device and in the driver use 
PCM-L,PCM-R or DSD-L,DSD-R depending on the input. Could be the unit works a 
bit differently then this, I will ask Mytek.

In the meanwhile, do you have any suggestions for things I could experiment 
with? I am not very familiar with the ALSA tree (yet). Meanwhile I will try to 
look in MPD source code for a bit, if I could set channel mappings there that 
might solve it too.
 
By the way, it seems that currently native 16-bit and 24-bit PCM formats are 
not supported since it always locks to 32-bit. I remember the "old", 2016, 
DICE driver did support 16-bit to my DAC, not sure about 24-bit. I am curious 
to why the new design is fixed to 32-bit, do you perhaps know?

[1] https://github.com/lintweaker/mytekusb2
[2] https://www.musicpd.org/doc/user/dsd.html
[3] https://github.com/MusicPlayerDaemon/MPD/blob/master/NEWS

Thank you,

Melvin Vermeeren
--nextPart9056532.X6Jb71ADgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETnzUjuV5O+rCrz6nRiwQnTrHuFkFAlr/MP8ACgkQRiwQnTrH
uFmZYg//dxySe1YU1VrnehothUj3r0hrn+igMzBLnXH4WJODX7d0YZ0l9kgEA62/
EB5UT2esFVYyiZ1of7JJW3LBnRJADbJ3MCL21gdygRYHIWVVPdktOOUFeIS6xqJj
q5gCwUvQl8yTUz2rqygOkJKPmBDhsh5Ux6CIxMeH2SIMpkmUjR3D1wpfS0MAzkHC
a375lP0o/0FRnWgfFXo5dUxbEhueJ8TJ+lyyhx7oGOj3v3yefcMhl1hrkpPKDMhG
zix0JL3bTj3eNnnAgDsSvwQBHK7u/Xe62amKP73HVPC/PxOOFwpDyPA04TJKV0nK
qsNeCcj/G9kaC62rMNzXEVlK3iS5FoMlg5gpkmyqI63S/pLirDKiKoGbjosHBmxD
Xx8zMh9td1WR44N439gY3HORzAfDb2TrZLgdtfpNOMe65sCV10x84/eDEHQOQqR3
FXSSN3noX+Aek4M2GSxJOgvVoAwTvGPTZM8L1bzB5Cl42oZVMrbogPo1Blv9yK4s
pnhzveRIgW8uIz65nG5uVT1R30dmXXMaSdZvDgskRxdISA0QS8sqWEoKVgOxgi8P
cHMCVJtydpU90Wy6UhGzSRSf18axsJsBE0qdHs3qne7BEvcURqA5GFIUwp5xexow
9/GnGeI/xWr8RQUmH8ut/1nm8VsMl/c/ySDvFMiy61V4XwVmVzk=
=AxaC
-----END PGP SIGNATURE-----

--nextPart9056532.X6Jb71ADgd--




--===============1675848210186270522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1675848210186270522==--
