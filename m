From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: [PATCH RFC 16/26] ALSA: rme32: Convert to
	copy_silence ops
Date: Sat, 2 Mar 2019 18:19:50 +0100
Message-ID: <3E5368DD-5DF4-48A8-A2AF-C19E5C473C8E@exactcode.de>
References: <20170511210925.18208-1-tiwai@suse.de>
 <20170511210925.18208-17-tiwai@suse.de>
 <29B2CB39-BCFF-4A04-9406-80059409BDEE@exactcode.de>
 <s5hva9cbymf.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0AAFF8961D
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 18:20:04 +0100 (CET)
In-Reply-To: <s5hva9cbymf.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 18 Jul 2018, at 12:56, Takashi Iwai <tiwai@suse.de> wrote:

>> to have another digital audio i/o card for our studio / office, I got a =
pair of RME32 the other week from ebay. (mostly as reference to implement A=
DAT for the RAD1 Sgi/Octane ALSA driver, =85)
>> =

>> Unfortunately they do not work with Linux. They are recognised and all t=
he usual devices and /proc/=85 entries show up, however, the hardware point=
er does not move during playback or capture no matter what clock source I c=
hoose.
>> I tried attaching coax s/pdif as well as an 8-channel Behringer Ultragai=
n ADAT source w/ clock.
> =

> Does the /proc/asound/card*/rme32 entry show the right setup?
> RME32 seems to have only few registers, and it behaves differently for
> read and write.  Maybe you should try to watch the register 0x20000.
> The hwptr is the LSB 33 bits.


thank you again for your reply, and I finally took a deep breath to "shortl=
y"
take a closer look at this again. So with current linux-kernel :HEAD nothing
has changed, and I get one IRQ when the playback starts.

As I do not have the spec I did a quick hack and commented out the IRQ
acknowledge around rme32.c line 829:

-                writel(0, rme32->iobase + RME32_IO_CONFIRM_ACTION_IRQ);

surprisingly this =93works=94 in that I have more than the first frame comi=
ng out of
the optical fibre, aka quite constant running pcm stream.

"Quite constant=94 because I think I sometimes (rarely) here some samples
getting lost, probably because the IRQ keeps firing as it was not acknowled=
ged.
However, I=92m surprised this works 99%ish anyway.

Of course the questions is now to actually properly fix this, as acknowledg=
ing
this IRQ somehow makes the card stop entirely, I guess, somehow? At least
that is how it looks like. Maybe you have an idea? Maybe some ALSA stream
helper refactoring broke something a decade ago?

I should probably also mention that this works with aplay, while with sox=
=92s
=93play=94 this hack is somehow producing constant under-run=92s:

In:85.6% 00:03:18.02 [00:00:33.35] Out:8.73M [!=3D=3D=3D=3D=3D|=3D=3D=3D=3D=
=3D!] Hd:0.0 Clip:0    play WARN alsa: under-run
play WARN alsa: under-run
play WARN alsa: under-run

which might be an indication of some stream pointer helper glue not being w=
ired up correctly anymore (I tested some seriously old version the last tim=
e, like 2.6.29=92ish, so this might be broken since over a decade or so alr=
eady)?

Thanks again for any tips, as otherwise I might spend many more hours tryin=
g to understand the FPGA and ALSA API.

Have a nice weekend,
	Ren=E9

-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin, https://exactcode.=
com
 https://exactscan.com | https://ocrkit.com | https://t2sde.org | https://r=
ene.rebe.de
