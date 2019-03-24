From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: [PATCH RFC] ALSA: rme32: fix interrupt ack for me
Date: Sun, 24 Mar 2019 12:19:49 +0100
Message-ID: <987F1B5F-5A22-4197-86F1-C48CEF47F0D2@exactcode.de>
References: <20170511210925.18208-1-tiwai@suse.de>
 <20170511210925.18208-17-tiwai@suse.de>
 <29B2CB39-BCFF-4A04-9406-80059409BDEE@exactcode.de>
 <s5hva9cbymf.wl-tiwai@suse.de>
 <3E5368DD-5DF4-48A8-A2AF-C19E5C473C8E@exactcode.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84384F80C17
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2019 12:20:04 +0100 (CET)
In-Reply-To: <3E5368DD-5DF4-48A8-A2AF-C19E5C473C8E@exactcode.de>
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

Hey,

On 02 Mar 2019, at 18:19, Ren=E9 Rebe <rene@exactcode.de> wrote:

> Hi Takashi,
> =

> On 18 Jul 2018, at 12:56, Takashi Iwai <tiwai@suse.de> wrote:
> =

>>> to have another digital audio i/o card for our studio / office, I got a=
 pair of RME32 the other week from ebay. (mostly as reference to implement =
ADAT for the RAD1 Sgi/Octane ALSA driver, =85)
>>> =

>>> Unfortunately they do not work with Linux. They are recognised and all =
the usual devices and /proc/=85 entries show up, however, the hardware poin=
ter does not move during playback or capture no matter what clock source I =
choose.
>>> I tried attaching coax s/pdif as well as an 8-channel Behringer Ultraga=
in ADAT source w/ clock.
>> =

>> Does the /proc/asound/card*/rme32 entry show the right setup?
>> RME32 seems to have only few registers, and it behaves differently for
>> read and write.  Maybe you should try to watch the register 0x20000.
>> The hwptr is the LSB 33 bits.
> =

> thank you again for your reply, and I finally took a deep breath to "shor=
tly"
> take a closer look at this again. So with current linux-kernel :HEAD noth=
ing
> has changed, and I get one IRQ when the playback starts.
> =

> As I do not have the spec I did a quick hack and commented out the IRQ
> acknowledge around rme32.c line 829:
> =

> -                writel(0, rme32->iobase + RME32_IO_CONFIRM_ACTION_IRQ);
> =

> surprisingly this =93works=94 in that I have more than the first frame co=
ming out of
> the optical fibre, aka quite constant running pcm stream.
> =

> "Quite constant=94 because I think I sometimes (rarely) here some samples
> getting lost, probably because the IRQ keeps firing as it was not acknowl=
edged.
> However, I=92m surprised this works 99%ish anyway.
> =

> Of course the questions is now to actually properly fix this, as acknowle=
dging
> this IRQ somehow makes the card stop entirely, I guess, somehow? At least
> that is how it looks like. Maybe you have an idea? Maybe some ALSA stream
> helper refactoring broke something a decade ago?
> =

> I should probably also mention that this works with aplay, while with sox=
=92s
> =93play=94 this hack is somehow producing constant under-run=92s:
> =

> In:85.6% 00:03:18.02 [00:00:33.35] Out:8.73M [!=3D=3D=3D=3D=3D|=3D=3D=3D=
=3D=3D!] Hd:0.0 Clip:0    play WARN alsa: under-run
> play WARN alsa: under-run
> play WARN alsa: under-run
> =

> which might be an indication of some stream pointer helper glue not being=
 wired up correctly anymore (I tested some seriously old version the last t=
ime, like 2.6.29=92ish, so this might be broken since over a decade or so a=
lready)?
> =

> Thanks again for any tips, as otherwise I might spend many more hours try=
ing to understand the FPGA and ALSA API.

So as the card sort of works in Windows,

	https://www.youtube.com/watch?v=3DdxMH3MMyKZ4

I spent some more time finding a workaround.

	https://www.youtube.com/watch?v=3D78-JxDzbHX8

Writing something else then 0 to the interrupt acknowledge register keeps t=
he stream running.
Writing 0xffffffff	causes the stream to corrupt.
So I thought maybe this FPGA bitstream copies this value into the command r=
egister,
and writing that register copy at least playback work for me now. Capture d=
oes still not work, but that is probably a story to be continued  another m=
onth:

--- linux-4.20/sound/pci/rme32.c.vanilla	2019-03-03 15:09:34.485653177 +0000
+++ linux-4.20/sound/pci/rme32.c	2019-03-03 15:09:51.077653422 +0000
@@ -863,7 +863,7 @@
 		if (rme32->playback_substream) {
 			snd_pcm_period_elapsed(rme32->playback_substream);
 		}
-		writel(0, rme32->iobase + RME32_IO_CONFIRM_ACTION_IRQ);
+		writel(rme32->wcreg, rme32->iobase + RME32_IO_CONFIRM_ACTION_IRQ);
 	}
 =

 	return IRQ_HANDLED;

In case this stupid Mail.app causes white space damages:
https://svn.exactcode.de/t2/trunk/package/base/linux/rme32-hothack.patch

PS: as per the above 3h video I read the disassembly and confirmed the valu=
e is
written into the RME32_IO_CONFIRM_ACTION_IRQ MMMIO location.

	Ren=E9
-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin, https://exactcode.=
com
 https://exactscan.com | https://ocrkit.com | https://t2sde.org | https://r=
ene.rebe.de
