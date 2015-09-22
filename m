From: Yaowei Bai <bywxiaobai@163.com>
Subject: Re: [PATCH 4/4] sound/core/seq: make prioq_match return bool
Date: Tue, 22 Sep 2015 21:22:57 +0800
Message-ID: <20150922132257.GB4221@bbox>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
 <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
 <1442844660.1876.2.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442844660.1876.2.camel@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: perex@perex.cz, tiwai@suse.com, k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 21, 2015 at 04:11:00PM +0200, Johannes Berg wrote:
> 
> > -static inline int prioq_match(struct snd_seq_event_cell *cell,
> > +static inline bool prioq_match(struct snd_seq_event_cell *cell,
> >  			      int client, int timestamp)
> 
> I think you should fix up the indentation now.

Sorry, I'm quite a new guy to linux kernel. I think you mean this patch
is not appropriate, right?

> 
> johannes
