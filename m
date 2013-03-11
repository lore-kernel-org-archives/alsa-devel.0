From: Daniel Mack <zonque@gmail.com>
Subject: Re: running 32 chan AD/DA on Linux
Date: Mon, 11 Mar 2013 11:02:10 +0100
Message-ID: <513DABA2.3010306@gmail.com>
References: <50F158F5.4050605@AntelopeAudio.com>
 <CAFa_cK=pShsoXHa8VGyERoCfn2+yPTeMBTMFAfsJaK0d-KEUuw@mail.gmail.com>
 <50F59673.4010603@AntelopeAudio.com>
 <CAFa_cKmfDC1NethK=p-f7bEWGvzCDLWpx0Y0qOSqic=-7qUb2A@mail.gmail.com>
 <50FBE020.7090606@AntelopeAudio.com>
 <CAFa_cK=fiRUXu2YNKkR8owx=B-MS+PR==PKPokzYXM+Q6XmcpQ@mail.gmail.com>
 <513D97CC.7060603@AntelopeAudio.com> <513D9A55.8050405@gmail.com>
 <513D9C38.1090901@AntelopeAudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FF9926086D
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 11:02:08 +0100 (CET)
Received: by mail-wi0-f177.google.com with SMTP id hm14so815593wib.4
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 03:02:08 -0700 (PDT)
In-Reply-To: <513D9C38.1090901@AntelopeAudio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Igor Levin <IgorL@AntelopeAudio.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

Hi Igor,

On 11.03.2013 09:56, Igor Levin wrote:
> Thank you so much for a quick answer, are you in Europe by any chance?

Yes, in Germany.

> Could you give us a link where we can browse the source code on the Net, 
> or tell us where to get those files
> mentioned as there seem to be so many Linux source files floating in the 
> web. Please forgive my ignorance
> if this question seems so naive, I am really a hardware engineer :)

There's Linus' repository which ends up in the official tarball releases
on a regular basis. You can browse that tree online in its cgit:


https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/usb/

> Do you believe the code base as it stands will work with 32 channels 
> In/Out pipes or do we need to
> get the unit to one of you guys to test it and make corrections as needed?

I'm not aware of any sound specific limitations in that area. Just try
it, and let us know how it goes. Sending the output of 'lsusb -v' for a
descriptor dump is mandatory in order to understand how your device is
designed.


Thanks,
Daniel
