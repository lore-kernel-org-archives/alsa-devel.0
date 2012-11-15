From: Colin Fletcher <colin.m.fletcher@googlemail.com>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Thu, 15 Nov 2012 19:34:35 +0000
Message-ID: <50A543CB.9080707@googlemail.com>
References: <50587F96.8080005@googlemail.com> <505883EA.6070808@ladisch.de>
 <5058898C.6020608@googlemail.com> <50588FE8.4070206@googlemail.com>
 <50A4EB06.1030404@googlemail.com> <50A4F8B8.5060704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AD9726161A
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 20:34:39 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id z49so700178wey.38
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 11:34:38 -0800 (PST)
In-Reply-To: <50A4F8B8.5060704@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 15/11/12 14:14, Clemens Ladisch wrote:
> Colin Fletcher wrote:
>> With kernel 2.6.38.8, aconnect can connect to the MIDI out of my
>> UA-1000; with 2.6.39, it fails, so it seems likely that it is the same
>> bug.
>
> It's the same bug, caused by this patch: http://git.kernel.org/linus/88a8516a2128
>
> Fix coming soon.

It's great to hear you know the cause of this. Thank you very much!

Armed with that information, I've found that replacing '#ifdef 
CONFIG_PM' with '#if 0' and commenting out calls to 
usb_autopm_{get|put}_interface() inside sound/usb/ gets me a working 
MIDI out on kernel 3.4.18 for now, which makes me happy.

If there's a proper patch I can usefully test, I'd be very glad to know 
about it.

Thank you.

Colin.
