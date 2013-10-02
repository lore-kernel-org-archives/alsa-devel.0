From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Realtek ALC286 SONY Vaio Pro 13 Ubuntu 13.10
Date: Wed, 2 Oct 2013 13:09:59 +0800
Message-ID: <CAN8cciZJeEg9dYai5kHFFgKgOeVTBTKAXdPzNUkuYN_V0v067g@mail.gmail.com>
References: <524652C0.5040207@uwo.ca> <52492D48.102@canonical.com>
 <524A67F1.5020300@uwo.ca> <524A6B88.2080802@canonical.com>
 <524B8139.2040309@uwo.ca> <524BA634.1010108@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CCEC0264F47
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 07:10:02 +0200 (CEST)
Received: by mail-ie0-f170.google.com with SMTP id x13so754655ief.29
 for <alsa-devel@alsa-project.org>; Tue, 01 Oct 2013 22:10:00 -0700 (PDT)
In-Reply-To: <524BA634.1010108@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>, Yuval Levy <ylevy@uwo.ca>, Takashi Iwai <tiwai@suse.de>, 1228689@bugs.launchpad.net, David Chen <david.chen@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > I have added this information to the bug report
> > <https://bugs.launchpad.net/bugs/1228689>
> > where I also post my comments so that they are more persistent and
> > available to other users with similar issues.
> >

http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=abdd8f510686da0a58e475bc0143d1069e5f53da

ALSA: hda - Apply ALC269 VAIO fix-up to all Sony laptops with ALC269
We've applied a fix-up for ALC269 VAIO only for two models.  But all Sony
VAIO models with ALC269 codec seem to require the similar fix.
Let's apply it with vendor-id mask.

Does it mean that the Fixup need to check whether node 0x19 must be valid
Mic pin if Sony Vaio pro 13 alc286 does not use node  0x19?
