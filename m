From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3 1/5] sound: pci: ctxfi: added reference
	of snd_card
Date: Mon, 22 Sep 2014 14:16:05 +0530
Message-ID: <20140922084605.GD4870@sudip-PC>
References: <1411315421-24138-1-git-send-email-sudipm.mukherjee@gmail.com>
 <s5h61gg6sq2.wl-tiwai@suse.de> <20140922081541.GC4870@sudip-PC>
 <s5hsijk5am8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9546526517C
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 10:46:14 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id r10so4002835pdi.39
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 01:46:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hsijk5am8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 22, 2014 at 10:21:19AM +0200, Takashi Iwai wrote:
> At Mon, 22 Sep 2014 13:45:41 +0530,
> Sudip Mukherjee wrote:
> > 
> > On Mon, Sep 22, 2014 at 09:04:53AM +0200, Takashi Iwai wrote:
> > > At Sun, 21 Sep 2014 21:33:37 +0530,
> > > Sudip Mukherjee wrote:
> > > > 
> > > > added and initialized a pointer of snd_card in the struct hw to get a reference of
> > > > the card in other functions
> > > 
> > > You need to explain why this change is needed.  The above text shows
> > > what it'd do, but it doesn't give any explanation to convince why this
> > > patch must be merged in.  In this case, it's a preliminary patch for
> > > the changes to convert to dev_*() later.  It's the most important bit,
> > > so don't forget it.
> > >
> > then do i mention in the commit that it is the preliminary patch for the later changes to dev_* ?
> 
> If the purpose of this patch is so, just write what it'll be used
> for.
> 
> > i was thinking that we can get a reference of the card from other functions which are using struct hw
> > is a reason by itself.
> 
> If the purpose of this patch is rather broader, just write what it'll
> be used for.
> 
> Do you see what was missing?
> 
understood.
thanks . I hope v4 will be a better series than this . 

sudip

> 
> Takashi
