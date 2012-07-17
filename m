From: Anisse Astier <anisse@astier.eu>
Subject: Re: Sound issues with ALC269VB-based hardware
Date: Tue, 17 Jul 2012 17:50:40 +0200
Message-ID: <20120717175040.55779252@destiny.ordissimo>
References: <20120717151109.66d239a5@destiny.ordissimo>
 <s5htxx6jum7.wl%tiwai@suse.de> <s5hmx2yjtoj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CFCBB265202
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 17:50:45 +0200 (CEST)
Received: by eaaa1 with SMTP id a1so205801eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 08:50:48 -0700 (PDT)
In-Reply-To: <s5hmx2yjtoj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Jul 2012 17:25:48 +0200, Takashi Iwai <tiwai@suse.de> wrote :

> At Tue, 17 Jul 2012 17:05:36 +0200,
> Takashi Iwai wrote:
> > 
> > All sounds like that your BIOS setup is broken.
> > 
> > You have two internal mics on 0x12 and 0x19.  Judging from your
> > comment, the pin 0x12 seems bogus.

Thanks, I will explore this and maybe come back to you.

> 
> BTW, this revealed a bug in the latest code.  Since phantom jack
> renaming, the account of ctl name index seems broken.  With this
> setup, the driver ended up with the duplicated internal mic phantom
> jack controls.

Glad I could help.

> 
> So I applied the patch below now.

I'm testing this right now to see if anything changes. (Although it
shouldn't if I understand well)

Anisse
