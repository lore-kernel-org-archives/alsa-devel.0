From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: pcm: Always honor DAI min and
 max sample rate constraints
Date: Wed, 27 Nov 2013 16:01:48 +0100
Message-ID: <5296095C.2080203@metafoo.de>
References: <1385542698-13362-1-git-send-email-lars@metafoo.de>
 <1385542698-13362-2-git-send-email-lars@metafoo.de>
 <s5hk3fu6sqt.wl%tiwai@suse.de> <5295D500.50607@metafoo.de>
 <s5h7gbu6q6y.wl%tiwai@suse.de> <20131127122153.GU14725@sirena.org.uk>
 <s5hwqju56oe.wl%tiwai@suse.de> <20131127144953.GV14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-141.synserver.de
 [212.40.185.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 95600261AB2
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 16:01:19 +0100 (CET)
In-Reply-To: <20131127144953.GV14725@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/27/2013 03:49 PM, Mark Brown wrote:
[...]
>> I think Lars' fix will handle such a case nicely now; at least,
>> merging between RATE bits and rate_min/max is solved, as long as the
>> given conditions are consistent.
> 
> Yes, it should work for the time being.  It just seems silly to have
> more than one set of merging code, it just increases the chances we'll
> get stuff wrong - switching to use the core constraint merging code
> should avoid the possibility of such errors in future.

There isn't such code in the ALSA core yet, but I guess it makes sense to
add it.

- Lars
