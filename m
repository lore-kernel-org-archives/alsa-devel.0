From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: [PATCH] ALSA: usb-audio: fix automatic
	Roland/Yamaha MIDI detection
Date: Fri, 16 Aug 2013 13:06:03 +0100
Message-ID: <1611840.QS8IH2v0gO@kamdesktop>
References: <51CC9D8B.7060601@ladisch.de> <52077FD9.6060404@ladisch.de>
 <1662775.3qSRSFOsFp@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ECD9261692
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 14:06:05 +0200 (CEST)
Received: by mail-wg0-f49.google.com with SMTP id y10so1456509wgg.28
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 05:06:05 -0700 (PDT)
In-Reply-To: <1662775.3qSRSFOsFp@kamdesktop>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 12 Aug 2013 23:38:22 Keith A. Milner wrote:
> On Sunday 11 Aug 2013 14:13:13 Clemens Ladisch wrote:
> > Commit aafe77cc45a5 (ALSA: usb-audio: add support for many Roland/Yamaha
> > devices) had several logic errors that prevented create_auto_midi_quirk
> > from enumerating any MIDI ports.
> > 
> > Reported-by: Keith A. Milner <maillist@superlative.org>
> > Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> > ---
> 
> I tested this with the BR-80. Logfile at the end.
> 

<SNIP>

> I do wonder whether a quirk is still needed for this device. It seems to be
> reporting as a 32-bit interface when it's actually only 16-bit, and I
> suspect this might be upsetting things.

With this in mind, I with a kernel where I had inserted the original BR-80 
quirk back into quirks-table.h.

This still didn't work, so there seems to be some other problem, unrelated to 
this patch.

Cheers,

Keith
