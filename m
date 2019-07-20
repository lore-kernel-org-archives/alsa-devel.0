From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Subject: Re: Surround speaker connection on Acer 8951G
Date: Sat, 20 Jul 2019 18:54:35 +0200
Message-ID: <20190720165435.GA5855@xn--80adja5bqm.su>
References: <20190404192430.GA24729@xn--80adja5bqm.su>
 <20190719111231.GA26592@xn--80adja5bqm.su>
 <s5hzhla9j8b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id AAAC1F8015B
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2019 18:54:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzhla9j8b.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Fri, Jul 19, 2019 at 04:44:52PM +0200, Takashi Iwai wrote:
> It might be some other external stuff like an external amp that is
> missing.  Often it's managed via GPIO or EAPD (that is controlled by
> HD-audio itself), but sometimes via a vendor-specific verb, or even
> over a completely different i2c...
> 
> In the case of vendor verbs, you can take a look at other quirks for
> similar models that touches lots of COEF stuff.

thanks for the pointers, does not sound simple, let's see if I get anywhere,
I will for sure try.

Odd that only one speaker would require such a special handling, but I guess
it is what it is.

In the meantime I found a more pressing issue where I also failed to find a
solution:

Pin 0x1b is resposible for rear speakers and at the same time for external
headphones. If I set the pin to "headphones" in hdajackretask, then
I "lose" the speaker and can't select a 5.1 profile. If I set it to internal
"speaker", the way I have it set up now, then sound comes out of speakers and 
headphones at the same time. 

"hdajacksensetest -a" will detect presence even if sensing is disabled in
hdajackretask, so I assume that this could be somehow used to mute
the speakers, but I was not able to figure out how to approach this.

This is quite an issue for audio conferencing, so I'd like to tackle this 
first and leave the LFE problem for later.

What would be the best way to solve this, how should this pin be configured?

Kind regards,
Jin
 
