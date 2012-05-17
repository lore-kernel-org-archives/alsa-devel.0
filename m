From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Adjust volume may cause audio playback corruption
Date: Thu, 17 May 2012 21:05:26 +0200
Message-ID: <4FB54BF6.3000901@ladisch.de>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>	<CAGXxSxWSD+c9tnJHsKVDJYhq=AkY4KfefZgPj6rtgQozzFjuiQ@mail.gmail.com>
	<CAGXxSxUYWLyRZ1BEz53TRY9aE-CPPxSRoZeNGE5QTsOKP=B+Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AAFFF103EC0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 21:05:47 +0200 (CEST)
In-Reply-To: <CAGXxSxUYWLyRZ1BEz53TRY9aE-CPPxSRoZeNGE5QTsOKP=B+Gg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: cee1 <fykcee1@gmail.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

cee1 wrote:
> We've found a way the can reproduce the problem more quickly on our product:
> 1. do audio playback
> 2. alsamixer, select 'Master', press 'm' and hold for a while.
>
> Then release 'm', playback corrupts(sounds similar to
> http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.ogg).

Is the output supposed to be playing or muted at this time?

This appears to be a problem with PA's volume handling.
It might be caused by incorrect dB volume information of the HDA codec,
or by a bug in PA.

> What does rewind do? Why we need rewind here?

It allows to rewrite already written parts of the audio buffer; it's used
to apply the new volume to samples that have not yet been actually played.


Regards,
Clemens
