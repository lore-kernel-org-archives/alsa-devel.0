From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 05/13] topology: Add PCM parser.
Date: Wed, 01 Jul 2015 17:20:14 +0100
Message-ID: <1435767614.29665.36.camel@loki>
References: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1435758275-4047-5-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hbnfvlurs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AA229260633
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 18:20:21 +0200 (CEST)
In-Reply-To: <s5hbnfvlurs.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-07-01 at 18:14 +0200, Takashi Iwai wrote:
> At Wed,  1 Jul 2015 14:44:27 +0100,
> Liam Girdwood wrote:
> > 
> inue;
> > +		}
> > +
> > +		if (strcmp(id, "ID") == 0) {
> 
> Only this word is capital letters while others are not?
> I don't mind too much, but just wondered, because currently the parser
> is case-sensitive.

Oh, I think this is just historical. It's probably likely that one of
the other developers had a preference for upper case or because it was
the shortened form of the word. I change this to lower case though.

Liam
