From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ALSA: hda: partially revert ALC268 quirk
	collapse
Date: Wed, 19 Aug 2009 21:51:59 +0400
Message-ID: <20090819175159.GA2546@x200.localdomain>
References: <20090815123846.GA19810@x200.localdomain>
	<s5hocqhccfj.wl%tiwai@suse.de>
	<20090815165338.GA2428@x200.localdomain>
	<s5hr5vchzbh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 79ECF244F5
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 19:52:04 +0200 (CEST)
Received: by ewy20 with SMTP id 20so4298700ewy.46
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 10:52:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hr5vchzbh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 16, 2009 at 11:40:02AM +0200, Takashi Iwai wrote:
> At Sat, 15 Aug 2009 20:53:38 +0400,
> Alexey Dobriyan wrote:
> > 
> > On Sat, Aug 15, 2009 at 05:41:04PM +0200, Takashi Iwai wrote:
> > > At Sat, 15 Aug 2009 16:38:46 +0400,
> > > Alexey Dobriyan wrote:
> > > > 
> > > > Fix alsamixer inability to start:
> > > > 
> > > > 	ALSA lib simple_none.c:1491:(simple_add1) helem (MIXER,'Master Playback Switch',0,3,0) appears twice or more
> > > > 
> > > > ALC268 codec shipped with Toshiba Satellite X200 has ids 1179:ff00 and
> > > > began to match quirk table.
> > > > 
> > > > If it doesn't match and auto-probe from BIOS is used, alsamixer works:
> > > > 
> > > > 	hda_codec: Unknown model for ALC268, trying auto-probe from BIOS...
> > > > 
> > > > 8871e5b91518a47284b6bc2603b44dbc79c85446 is first bad commit
> > > > commit 8871e5b91518a47284b6bc2603b44dbc79c85446
> > > > Author: Takashi Iwai <tiwai@suse.de>
> > > > Date:   Tue Jun 2 01:02:50 2009 +0200
> > > > 
> > > >     ALSA: hda - Reorder and clean-up ALC268 quirk table
> > > >     
> > > >     Rearrange alc268_cfg_tbl[] in the order of vendor id, and group some
> > > >     entries using SND_PCI_QUIRK_MASK().
> > > >     
> > > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > 
> > > > :040000 040000 2497bb6fc5305acf3191b8e9b82956ec0ea1aee9 6f1d9ff9fed20550a1b2b398c7d2d5fec705fcd9 M      sound
> > > > 
> > > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > 
> > > Well, it's no right fix.  The symptom implies that something wrong
> > > with the current model=toshiba, so fixing the quirk is the way to go
> > > at this moment.
> > > 
> > > Could you give alsa-info.sh output (run with --no-upload option)
> > > as vanilla kernel?  Run with both model=auto and without model option
> > > and attach both results to compare.  The former means actually the
> > > condition as your patch does.
> > 
> > Here is diff for quick look:
> 
> Thanks.  The problem is that this laptop has two ALC268 codecs, and
> these conflict.
> 
> Could you try the patch below?

It helps, thank you.

Tested-by: Alexey Dobriyan <adobriyan@gmail.com>
