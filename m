From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Thu, 28 Nov 2013 09:42:05 -0500
Message-ID: <CAPrbH=tu0jTctOAegkT7tnq1VSGOui4cESA2rYJFfgCa3=tQDg@mail.gmail.com>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <20131124130335.GA23126@tamtam.fritz.box>
 <CAPrbH=tGph7__rgx-5BsBSi9-E95FpsTL9Yy0zbum0TccTPbyQ@mail.gmail.com>
 <20131124141803.GC23126@tamtam.fritz.box>
 <CAPrbH=sA5ppp8z3bqdaDnk4U+DZ093ukXpDgiT6DEixGi1tdZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D28812651A0
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:42:25 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id w61so2635282wes.0
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 06:42:25 -0800 (PST)
In-Reply-To: <CAPrbH=sA5ppp8z3bqdaDnk4U+DZ093ukXpDgiT6DEixGi1tdZA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was able to compile 3.11.9 for AVLinux.  The quirk does not work, dmesg
returns this:

[   40.759383] usb 2-8: New USB device found, idVendor=1686, idProduct=00dd
[   40.759387] usb 2-8: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[   40.759390] usb 2-8: Product: R16
[   40.759393] usb 2-8: Manufacturer: ZOOM Corporation
[   40.759396] usb 2-8: SerialNumber: 0
[   40.760214] snd-usb-audio: probe of 2-8:1.0 failed with error -5
[   45.760206] 6:1:1: cannot get freq at ep 0x3
[   55.761231] 6:2:1: cannot get freq at ep 0x84




On Tue, Nov 26, 2013 at 1:22 PM, Jason Mancine <jason@mancine.net> wrote:

> Can't seem to compile 3.11 or 3.12 for the distro I am using (AVLInux)...
> tested it in Ubuntu Studio 13.10 and the quirk didn't seem to have any
> effect.  The output of lsusb is the same, but the device doesn't show up as
> a sound card.
>
>
> On Sun, Nov 24, 2013 at 9:18 AM, Daniel Mack <daniel@zonque.org> wrote:
>
>> On Sun, Nov 24, 2013 at 09:03:47AM -0500, Jason Mancine wrote:
>> > Thanks, I will give it a try.  By recent kernel do you mean latest
>> mainline
>> > or should my distro's 3.6.11 be new enough?
>>
>> Anything >= 3.11 should do.
>>
>> In further replies, please do not drop the alsa-devel mailing list.
>>
>>
>> Thanks,
>> Daniel
>>
>
>
