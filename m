From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] ALSA: hda - add mic fixup for ALC269VB on
 Ordissimo EVE2
Date: Wed, 5 Jun 2013 12:32:18 +0200
Message-ID: <20130605123218.65ad62e1@serenity>
References: <20120717151109.66d239a5@destiny.ordissimo>
 <1370253190-25072-1-git-send-email-anisse@astier.eu>
 <s5hehcgvong.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 710A2261A42
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 12:32:57 +0200 (CEST)
Received: by mail-wi0-f169.google.com with SMTP id hn14so4800463wib.4
 for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2013 03:32:54 -0700 (PDT)
In-Reply-To: <s5hehcgvong.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 05 Jun 2013 12:26:59 +0200, Takashi Iwai <tiwai@suse.de> wrote :

> At Mon,  3 Jun 2013 11:53:10 +0200,
> Anisse Astier wrote:
> > 
> > This fixes the internal and external mic on Ordissimo EVE2,  also known
> > as Malata PC-B1303.
> > 
> > We still don't know how to detect mic jack like Realtek's windows
> > driver.
> > 
> > Signed-off-by: Anisse Astier <anisse@astier.eu>
> 
> Thanks, applied.
> 
> > ---
> > Hi,
> > 
> > I'm on a dead end on this computer, I can't seem to find how the mic jack
> > presence works. It's always on(presence detected whatever the status) on NID
> > 0x18, the one used for the external mic. I have tried every NID, manually
> > enabling pin_sense on each, but only the headphone jack detection works. The
> > mic sense is nowhere to be seen.
> 
> I also don't know any other method for Realtek.  For IDT codecs, there
> are some devices with GPIO unsol events, but Realtek codecs seem to
> use only the normal pin detection unsol events.
> 
> So, on your device, GET_PIN_SENSE doesn't return the detection bit
> set?  You tried setting SET_PIN_SENSE before GET_PIN_SENSE, right?
> 
> 

Yes, I tried it although the ALC269 datasheet states that it's a NO-OP.

Anisse
