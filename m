From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 08:44:24 -0500
Message-ID: <w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C521103913
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 15:44:26 +0200 (CEST)
Received: by iwn27 with SMTP id 27so219002iwn.5
	for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2010 06:44:24 -0700 (PDT)
In-Reply-To: <4BDABDDD.4050502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

>> When PulseAudio is used and all PCM is routed through PulseAudio
>> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
>> So why not disable them entirely to reduce the number of wakeups? ...
>> There are probably some cases where you don't want this type of
>> behavior (broken hardware, legacy code with multiple-buffering,
>> disabled timer in PulseAudio),
>
> It's interesting that all ALSA applications except PA are "legacy". =A0:)

Ha. Nice slip. I didn't mean legacy was bad... It's perfectly ok to
use multiple buffers and interrupts in a variety of apps.

>> so I think it would make sense to request the disabling of interrupts
>> when hw_params are set, since this is also the time when period sizes
>> are set.
>
> Yes. =A0For compatibility with the existing ALSA API, this needs to be
> a flag that is not enabled by default.

Agreed. This shouldn't even be mandatory since this option might not
be possible in all platforms.

>> I am aware that some changes would be needed in pcm_lib.c, where all
>> the error checks are done.
>
> Plus all the API changes in the ALSA kernel framework, the ALSA kernel/
> userspace interface, and the alsa-lib interface.

I am not following this point. If you add a simple flag to an existing
interface, why would we need to change the kernel/userspace inferface?
This change should be possible in a backwards compatible manner as an
additional option provided to the application developer.
Cheers
-Pierre
