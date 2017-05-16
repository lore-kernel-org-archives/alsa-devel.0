From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 10/13] sound: fix the comments that refers to kernel-doc
Date: Tue, 16 May 2017 07:55:03 -0300
Message-ID: <20170516075503.24d0ecc5@vento.lan>
References: <cover.1494775891.git.mchehab@s-opensource.com>
        <3514c2b81341c160bf6753cb47fa2346f3b5a0e7.1494775891.git.mchehab@s-opensource.com>
        <s5hshk6bied.wl-tiwai@suse.de>
        <20170516074653.187d499f@vento.lan>
        <s5hvap1f52o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <s5hvap1f52o.wl-tiwai@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em Tue, 16 May 2017 12:50:55 +0200
Takashi Iwai <tiwai@suse.de> escreveu:

> On Tue, 16 May 2017 12:46:53 +0200,
> Mauro Carvalho Chehab wrote:
> > 
> > Em Mon, 15 May 2017 11:04:26 +0200
> > Takashi Iwai <tiwai@suse.de> escreveu:
> >   
> > > On Sun, 14 May 2017 17:38:44 +0200,
> > > Mauro Carvalho Chehab wrote:  
> > > > 
> > > > The markup inside the #if 0 comment actually refers to a
> > > > kernel-doc markup. As we're getting rid of DocBook update it.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>    
> > > 
> > > I guess you prefer taking it from your tree?  Feel free to take my
> > > ack:
> > >   Reviewed-by: Takashi Iwai <tiwai@suse.de>  
> > 
> > In the specific case of this patch, it doesn't matter much from what
> > tree it would be merged, as no other patch depends on it ;)
> > 
> > So, if you prefer, you can merge it directly on your tree. Otherwise,
> > I'll keep it on my pile of patches to be send to docs -next.  
> 
> OK, since the PCM stuff is being changed for 4.13, may be it's safer
> that I take this patch in sound git tree.

OK! I'll remove from my patch pile :-)

Thanks,
Mauro
