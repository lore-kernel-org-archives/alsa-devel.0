From: Daniel Mack <zonque@gmail.com>
Subject: Re: Regression in sound/usb/
Date: Thu, 12 Jul 2012 15:20:36 +0200
Message-ID: <4FFECF24.6060906@gmail.com>
References: <CADYPuQ75GAxGyZgiUwygvnQMmDcL9+NMHNo432kg1RYC7vbfQA@mail.gmail.com>
	<4FF18FCF.6020306@gmail.com>
	<CADYPuQ5RFJAaFDpT+4XM-JDWzDO5czVAU3A++_HVHjhN=VBhvQ@mail.gmail.com>
	<s5hvci55l68.wl%tiwai@suse.de>
	<CADYPuQ4Uj8pq9nZOJemY9kZtSrG-WfG4s90b+a00_KteJXU_Sg@mail.gmail.com>
	<s5hr4st5jx1.wl%tiwai@suse.de>
	<CADYPuQ6DT4=NW2tzCLrKYnUHQ6p5qONZjY8PeKq-Z4HAk68tpw@mail.gmail.com>
	<s5hk3yl5ibt.wl%tiwai@suse.de> <s5hhatmjmna.wl%tiwai@suse.de>
	<CADYPuQ7yWpnPSvoVQDV+EyJfC39MDxhP9r5Jiqk_Jh8g65Xd4g@mail.gmail.com>
	<s5h8vey43ve.wl%tiwai@suse.de> <4FFC9B4F.6060600@gmail.com>
	<CADYPuQ6XRSAxKvctCr3FrJ71smk-xOEMF_5VAv-6F5gdM7dwuQ@mail.gmail.com>
	<4FFE07EF.6070900@gmail.com>
	<CADYPuQ5sE28JRXLaBUYzjqvuJyWY9cWUCM4mYFByYQUXppDOQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 741E82440D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 15:27:54 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1643407bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2012 06:27:54 -0700 (PDT)
In-Reply-To: <CADYPuQ5sE28JRXLaBUYzjqvuJyWY9cWUCM4mYFByYQUXppDOQA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Dreimann <philipp@dreimann.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 12.07.2012 11:18, Philipp Dreimann wrote:
> On 12 July 2012 01:10, Daniel Mack <zonque@gmail.com> wrote:
>> On 11.07.2012 09:30, Philipp Dreimann wrote:
>>
>>> The camera is now working for a short time:
>>> [   56.421399] usb 2-1.2: new high-speed USB device number 4 using ehci_hcd
>>> [   57.224234] uvcvideo: Found UVC 1.00 device <unnamed> (046d:0821)
>>> [   57.237221] input: UVC Camera (046d:0821) as
>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/input/input15
>>> Camera and microphone are working. Some time later we're back to the old issue:
>>
>> So I found the reason for this breakage now. It's about orphaned packets
>> that are sent over the wire after alt setting 0 has been selected. The
>> chipset doesn't like these at and bails out with protocol errors. Fixing
>> this involves some rework of the logic. The patch is unfortunately a
>> little big, but I see no option than getting it merged for 3.6.
> 
> The issue seems to be fixed for me. Let's hope that it'll make it in
> the next v3.5-rc.

Thanks for testing. I just sent two patches. Combined, they are
identical to what you tested. Anyone else wants to add a Tested-by?

Thanks,
Daniel
