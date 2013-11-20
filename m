From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [Report] ALSO: hda - CA0132: Bugs and missing
	features
Date: Wed, 20 Nov 2013 10:10:01 -0800
Message-ID: <CAEUnVG4KukHXSSiJgQSyBt8gJY+=mw1BnKqiK3Ht-RgrXiAY7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B84A9261A1F
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 19:10:22 +0100 (CET)
Received: by mail-qc0-f174.google.com with SMTP id r5so2162267qcx.5
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 10:10:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Reis <andreas.reis@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 19, 2013 at 8:08 AM, Andreas Reis <andreas.reis@gmail.com> wrote:
> Correction: The other jack duplicated for the front panel is Mic In
> (no mention of the rear panel jack's shared Line In functionality
> here), not Rear Speaker Out.
>
> On Tue, Nov 19, 2013 at 5:04 PM, Andreas Reis <andreas.reis@gmail.com> wrote:
>> Posting here by Takashi's advice after my alsa-user post remained unanswered.
>>
>> There are a number of grave issues with the CA0132 codec on my
>> Gigabyte G1.Sniper M5 (rev. 1.0) (Intel Z87, Recon3Di onboard, latest
>> bios F8c). I've tried kernels (x64) from 3.9 to 3.13-preRC1 (as
>> currently in Torvald's git), both with pulse on Ubuntu 13.10 and
>> without on Arch Linux.
>>

Sorry I don't have good news for you.  The CA0132 is very dependent on
the firmware that is loaded into the DSP that resides in the codec.

To get your system to work you'll have to obtain the firmware that was
designed for your motherboard, then change the Linux driver to be able
to talk to it, without a spec for how it works.

This is not impossible, but it would be rather time consuming.

-Dylan
