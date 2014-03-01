From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Sat, 01 Mar 2014 18:40:31 +1100
Message-ID: <53118EEF.8060304@gmail.com>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 48BF526529F
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 08:41:08 +0100 (CET)
Received: by mail-pd0-f179.google.com with SMTP id w10so1681231pde.24
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 23:41:06 -0800 (PST)
In-Reply-To: <52E5CC2E.1010000@gmail.com>
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

Hi Clemens,

I wish to bring to your attention that the patch I submitted previously
(0001-Cleaned-up-Digidesign-Mbox-1-patch.patch) has been working for the
last two months on my device and other people have also reported
complete success with it. (see http://www.zamaudio.com/?p=953 for details).

We discovered and fixed an issue with outdated firmware causing sporadic
white noise on the device; Avid (the manufacturer) provided an update
which fixed this issue entirely (v0.22).  Unfortunately, the firmware
update can only be applied using a Mac computer since it is bundled in a
.dmg installer.

If users do not apply the firmware update, the device will still work
with linux, but every second or third time they open a playback stream
there is a loud fuzzing noise which could possibly damage external
equipment.  I suppose it is caused by a bug in the firmware.

Therefore, with the official updated firmware and my usb-audio quirk
provided in the previous post, I am pleased to say that Digidesign Mbox
1 (0dba:1000) works well in duplex mode, in both 44100 and 48000Hz modes
(SPDIF untested).

I am keen to get my patch into the kernel with your recommendations for
cleaning up the code.

Although I have not inspected the inside of the unit, in my opinion it
has higher quality converters and preamps than the second generation
models.  Also, even though it is powered by dirty USB power, it is
surprisingly quiet on the main outputs when silence is playing.

Regards,
Damien

On 27/01/14 14:02, Damien Zammit wrote:
> On 27/01/14 03:52, Clemens Ladisch wrote:
>>> This patch creates a dual endpoint quirk.
>>> >The quirk interface needs a second audioformat struct for this to work
>>> >which I called ".data2".
>> Couldn't you just let .data point to an array of two structs?
> 
> Thanks Clemens, I have created a new patch using this suggestion.
> 
> Damien
