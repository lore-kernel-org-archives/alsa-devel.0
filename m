From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [alsa-utils] alsaucm should come with a man page
Date: Mon, 8 Aug 2016 18:30:41 +0200
Message-ID: <20160808183041.783253de1e523d05bb529760@ao2.it>
References: <20160727114828.9d6c709d80084b659426e6cc@ao2.it>
 <s5hmvkt975u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 17D1E26660B
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 18:30:45 +0200 (CEST)
In-Reply-To: <s5hmvkt975u.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Justin Xu <justinx@slimlogic.co.uk>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 03 Aug 2016 17:57:49 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 27 Jul 2016 11:48:28 +0200,
> Antonio Ospite wrote:
> > 
> > Hi,
> > 
> > I used alsaucm to test mixer use cases for an Intel Baytrail tablet, I
> > wanted to use bare alsa before bringing pulseaudio in, and it took some
> > time to get my head around it.
[...]
> > However, my point is that a man page explaining these things can make
> > the life easier to new users.
> > 
> > It would be better if alsa/UCM developers wrote the man page, but if no
> > one steps up I guess I could draft a first version myself.
> 
> Go ahead, please post your draft version.  That's already helpful.
> 

OK, I will.

The first version will be in a readable text format (maybe asciidoc),
this makes writing and reviewing the content a lot easier.

Then, if depending on an external tool to generate the man page
automatically is not acceptable for alsa-utils, I will format the
approved content manually following the style used in the man pages of
the other alsa programs.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
