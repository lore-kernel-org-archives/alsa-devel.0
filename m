From: Simon Derr <ddrsimon@gmail.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Thu, 30 Apr 2015 22:39:19 +0200
Message-ID: <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
 <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
 <s5hy4la6vgn.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A4E11261ABF
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:39:39 +0200 (CEST)
Received: by wgen6 with SMTP id n6so74884534wge.3
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:39:39 -0700 (PDT)
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Kailang, is there anything special in ALC3236 regarding the
>> mic boost handling?  Here, the problem is that the machine
>> doesn't get builtin mic working when mic boost is set more
>> than 0, and 0 gives only low signals.  alsa-info.sh is at:

>> You may try some existing quirk for Dell laptops, e.g.
>> model=dell-headset-multi.  In your case, the realtek codec is
>> the second one, so pass "model=,dell-headset-multi" (give a
>> comma at first)

Hi,

Good news : setting model=,headset-mic seems to solve all my issues.
The jack mic works, the internal mic works, and the boost works.
Does that make sense to you ?

Anyway, thanks a lot for your help.

May I suggest updating the list of codec variants in HD-Audio-Models.txt ?
I originally thought none of the quirks applied to my codec because
neither ALC3236 nor ALC233 was listed there.

Regards,


   Simon
