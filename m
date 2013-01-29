From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Tue, 29 Jan 2013 10:39:24 +0100
Message-ID: <510798CC.3080006@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id AC00F265339
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 10:39:28 +0100 (CET)
In-Reply-To: <5107188F.3060001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 29.1.2013 01:32, Jonas Petersen wrote:
> Am 28.01.2013 13:36, schrieb Pavel Hofman:
>> Right, looks like a bug in snd_ak4114_create. Nevertheless the 7th reg
>> RCS0 is read-only, writing anything bogus should not affect the
>> operation.
> Ok. I once filled it with a zero with no effect.

That is what I thought. We will fix the code though.
> 
>> What does the ak4114 regs dump in /proc/asound... dir of your
>> audiophile192 look like? The snd_ak4114_proc_regs_read method reads real
>> values from the regs.
> You know what, there ist no ak4114... See the attached
> Audiophile192-proc.txt. That's everything in proc.
> Before I was doing some printk's in snd_ak4114_create() and
> snd_ak4114_reg_write() and other places. They ended up in kern.log.
> Then was also fiddling around with the configuration (ak4114_init_vals)
> which didn't change anything in the capture behaviour. I even entirely
> removed the snd_ak4114_create() call. It was still just capturing spdif
> 6 dB to loud with the shifted signals as described before.
> So the ak4114 code is not in operation at all?

First, please tell us your alsa version (/proc/asound/version)

Please move the ak4114 init call from the controls section to the init
section (just like in juli.c) and test:

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 7641080..bb6c82a 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -562,6 +562,9 @@ static int revo_init(struct snd_ice1712 *ice)
                                               ice);
                if (err < 0)
                        return err;
+               err = ap192_ak4114_init(ice);
+               if (err < 0)
+                       return err;

                /* unmute all codecs */
                snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
@@ -597,9 +600,6 @@ static int revo_add_controls(struct snd_ice1712 *ice)
                err = snd_ice1712_akm4xxx_build_controls(ice);
                if (err < 0)
                        return err;
-               err = ap192_ak4114_init(ice);
-               if (err < 0)
-                       return err;
                break;
        }
        return 0;

> 
> 
>>> @Pavel, btw. I also have an ESI Juli@. Spdif capture with this one
>>> does not
>>> work at all (as compared to "kind of working" with the Audiophile 192).
>> Interesting. I am pretty sure I tested the SPDIF input of Juli quite
>> extensively. It even reported the incoming samplerate correctly. How did
>> you test it? Please list amixer contents and ak4114 regs here. Thanks.
> 
> I just tried again. The Juli just seem to freeze the whole alsa when I
> try to access the spdif input.

OK, let's do some troubleshooting. Do you have SPDIF signal present at
Juli's input when you try to capture?

Does it lock the moment you open the capture stream (i.e. start the
capturing), or when you switch the rate selector to IEC958-In?


What is your kernel (uname -a)?

Regards,

Pavel.
