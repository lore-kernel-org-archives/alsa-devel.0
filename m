From: Sean McNamara <smcnam@gmail.com>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 12:08:57 -0400
Message-ID: <CAPAActeAqyEW_YtYm-aK8u-c=Ej9qsc4o5QHaj-nM9i9LX8+hQ@mail.gmail.com>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
	<4E70C260.3040001@ladisch.de>
	<CA+jNppnG5UbUOuxqDc-kmR5-pO1n7BX4922d109XV66jXyR-Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 603D02434F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 18:09:03 +0200 (CEST)
Received: by iabn5 with SMTP id n5so298125iab.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 09:09:02 -0700 (PDT)
In-Reply-To: <CA+jNppnG5UbUOuxqDc-kmR5-pO1n7BX4922d109XV66jXyR-Jg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Sep 14, 2011 at 11:20 AM, Mike Crowe <drmikecrowe@gmail.com> wrote:
>> Does the changing of the rate actually succeed?
>>
>
> Surprisingly, that's hard to answer. =A0Normally, most of our audio is
> at 48K (we control the sound files), so the device stays at that rate.
> =A0However, a new library we added (for voip communications) is
> hard-coded to 8K sample rate via OSS, and I'm now trying to work out
> dual usage by our ALSA code and this library's OSS interface.
>
> Before I added these kernel printouts, I was convinced the system was
> switching rates properly (because I added 8K rate support to the
> hardware driver to get the voip library working). =A0However, my current
> debug load shows the rate changing in the pcm_oss module, but I never
> see that rate hit the hardware the way I expected.
>
> If it isn't hitting the hardware, I suppose it could be up/down
> converted by ALSA, but I don't have any plugins installed. =A0I thought
> I needed a plugin for ALSA to convert between the two rates, right?

Right, but if you're using the in-kernel OSS emulation, it bypasses
the userspace ALSA-lib plug layer! You'll have to resample it in
userspace within the OSS application, probably.

Or, you can use osspd (sometimes referred to as ossp or oss-proxy):
http://sourceforge.net/projects/osspd/

osspd has the advantage that most of the ugly stuff is done in
userspace, and you also get to take advantage of any software mixing
or resampling you may have, whether it's at the alsa-lib plug layer,
or a pulseaudio daemon. ossp can re-route audio from a "real" /dev/dsp
character device to either alsa-lib or pulseaudio in userspace. Pretty
amazing, huh? :)

I'm not an embedded developer, but from my point of view, I don't see
how anyone should want to use the in-kernel OSS emulation as it stands
in any production applications, because (1) it hogs the sound device
completely, preventing any other apps from interfacing with the
hardware simultaneously; (2) you can't apply any user-level
transformations or remixing of the audio, via e.g. alsa-lib plugins,
nor can you control the audio using the use-case framework (UCM) being
developed for pulseaudio; (3) the user (and corresponding developer)
base for the in-kernel OSS driver is somewhat low, relative to using
ALSA in userland, and emulating OSS in userland as well.

Depending on just *how* embedded your device is (is it a high-end
tablet/smartphone or a tiny industrial control, etc) you may or may
not like osspd as a solution, because it involves some extra context
switches and overhead, which does not occur if you use e.g. a native
OSS audio stack or the OSS in-kernel driver.

I just find myself personally unable to use a system without software
mixing, so unless you're willing to permanently live without that
feature for the lifetime of your platform architecture, you may want
to look at osspd. I can certainly see a case where a simple embedded
device might not need mixing though, so you may have a valid use case
for snd_pcm_oss after all (and I don't have to like it, hehe).

HTH,

Sean

>
> Thanks!
> Mike
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
