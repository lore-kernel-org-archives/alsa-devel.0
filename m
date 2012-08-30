From: Anisse Astier <anisse@astier.eu>
Subject: Re: Sound issues with ALC269VB-based hardware
Date: Thu, 30 Aug 2012 18:57:11 +0200
Message-ID: <20120830185711.1326d311@destiny.ordissimo>
References: <20120717151109.66d239a5@destiny.ordissimo>
 <s5htxx6jum7.wl%tiwai@suse.de> <s5hmx2yjtoj.wl%tiwai@suse.de>
 <20120717175040.55779252@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D9CA5265DB2
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 18:57:28 +0200 (CEST)
Received: by eeke50 with SMTP id e50so712536eek.38
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 09:57:28 -0700 (PDT)
In-Reply-To: <20120717175040.55779252@destiny.ordissimo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi again,

On Tue, 17 Jul 2012 17:50:40 +0200, Anisse Astier <anisse@astier.eu> wrote :

> On Tue, 17 Jul 2012 17:25:48 +0200, Takashi Iwai <tiwai@suse.de> wrote :
> 
> > At Tue, 17 Jul 2012 17:05:36 +0200,
> > Takashi Iwai wrote:
> > > 
> > > All sounds like that your BIOS setup is broken.
> > > 
> > > You have two internal mics on 0x12 and 0x19.  Judging from your
> > > comment, the pin 0x12 seems bogus.
> 
> Thanks, I will explore this and maybe come back to you.
> 

I used David's tool and came up with this fixup:

[codec]
0x10ec0269 0x1b7da831 0

[pincfg]
0x18 0x411111f0
0x12 0x99a3092f


The problem is I can't seem to get a sense on the mic port (0x19).

I tried it on Windows, and the Realtek HD Audio tool can detect the jack
on the headphone and mic port independently. I didn't use any
vendor-provided (oem specific) driver on Windows.

Regards,

Anisse
