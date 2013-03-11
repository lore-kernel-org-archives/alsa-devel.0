From: Daniel Mack <zonque@gmail.com>
Subject: Re: running 32 chan AD/DA on Linux
Date: Mon, 11 Mar 2013 09:48:21 +0100
Message-ID: <513D9A55.8050405@gmail.com>
References: <50F158F5.4050605@AntelopeAudio.com>
 <CAFa_cK=pShsoXHa8VGyERoCfn2+yPTeMBTMFAfsJaK0d-KEUuw@mail.gmail.com>
 <50F59673.4010603@AntelopeAudio.com>
 <CAFa_cKmfDC1NethK=p-f7bEWGvzCDLWpx0Y0qOSqic=-7qUb2A@mail.gmail.com>
 <50FBE020.7090606@AntelopeAudio.com>
 <CAFa_cK=fiRUXu2YNKkR8owx=B-MS+PR==PKPokzYXM+Q6XmcpQ@mail.gmail.com>
 <513D97CC.7060603@AntelopeAudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C3AFA26030A
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 09:49:15 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so1557183bkc.38
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 01:49:15 -0700 (PDT)
In-Reply-To: <513D97CC.7060603@AntelopeAudio.com>
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

please don't remove the alsa ML from Cc:.

On 11.03.2013 09:37, Igor Levin wrote:

[...]

> But now we got a bit of a breather and our developers are finally able
> to give Linux the attention it deserves
> to get it going. I have couple fundamental question which you guys can
> help us with:
> 
> 1) Does Linux audio support the Implicit feedback mode where the Out
> pipe will source the same amount of
>      samples as are coming into related IN pipe.

Yes.

>  This is the sync mode
> we use in Orion 32. If this is so, could
>     you kindly provide the file/line number in the source code where we
> can see how it makes the packetising
>      decision.

Please have a look at sound/usb/endpoint.c - this is where the packet
logic lives in. Please read the comments in this file - the packet
sending for this implicit feedback mode is implemented in
queue_pending_output_urbs().

> 2) We are upgrading our Zodiac DAC to use asynchronous feedback mode.
> What Async feedback mode formats
>      does Linux support? Where can we see it in the source?

Linux supports feedback over dedicated isochronous endpoints as well.
The format is auto-detected in snd_usb_handle_sync_urb(), also in
sound/usb/endpoint.c, after each stream start. Internally, the driver
uses Q16.16.

Hope this helps. In case of more specific questions, please just let me
know.


Thanks,
Daniel
