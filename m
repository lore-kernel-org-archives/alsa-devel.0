From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: [PATCH] ALSA: usb-audio: fix automatic
	Roland/Yamaha MIDI detection
Date: Mon, 12 Aug 2013 23:42:20 +0100
Message-ID: <13112595.4hqtLUMLO6@kamdesktop>
References: <51CC9D8B.7060601@ladisch.de> <52077FD9.6060404@ladisch.de>
 <1662775.3qSRSFOsFp@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f173.google.com (mail-ea0-f173.google.com
 [209.85.215.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B9988265019
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 00:42:25 +0200 (CEST)
Received: by mail-ea0-f173.google.com with SMTP id g10so3734849eak.32
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 15:42:25 -0700 (PDT)
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

I forgot to mention MIDI works well on this device. Sending notes to Ch 10 
plays the onboard drum synth.

Cheers,

Keith
