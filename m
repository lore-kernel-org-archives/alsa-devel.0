From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: Re: [PATCH v3 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Mon, 23 Mar 2015 12:08:17 +0200
Message-ID: <1427105297.2968.19.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <1426865953-1606-2-git-send-email-yang.jie@intel.com>
 <s5ha8z7zlrd.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDBBA0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9BB260555
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 11:08:22 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDBBA0@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-03-21 at 02:22 +0000, Jie, Yang wrote:
> > As you'll find through the whole output, many calls are combined with
> > SND_JACK_BTN_* bits.  And think again how this will result with your patch.
> > A call like
> > 
> > 	snd_soc_card_jack_new(card, "Headphone",
> > 		SND_JACK_HEADPHONE | SND_JACK_BTN_0 |
> > SND_JACK_BTN_1, ...)
> > 
> > would give three kctls, all "Headphone Jack" with indices 0, 1 and 2.
> > How user-space knows what is for what?
> [Keyon] yes, this is an issue I was thinking about, we need discussing and conclusion
> about that, including comments from user-space, here adding Tanu.
> Here I am thinking about
> 1. do we really need kctls for buttons(SND_JACK_BTN_n)? if no, that is simplest, 
> we can filter out them at this kctl creating stage.
> 2. if yes, then we need an name regenerator here, to generate understandable
> (for user-space) kctl names for buttons.

>From PulseAudio point of view, you must make sure that "Headphone Jack"
with index 0 doesn't refer to a button, because the assumption is that
"Headphone Jack" at index 0 refers to a jack and not a button (indexes
other than 0 are currently ignored). Other than that, PulseAudio doesn't
currently care, because there's no support for buttons.

When thinking about how to implement button support in PulseAudio, the
first question is that are kcontrols a realiable interface for getting
button events? What happens when the button is pressed? Does one press
cause only one on->off or off->on state transition, or is the state "on"
only for the duration of the press? If the former, then kcontrols should
be fine, but if the latter, is it guaranteed that the application sees
the event? If the button press is a short one, causing a quick
off->on->off transition, is it possible that the application gets a
notification of a mixer change, but when the application then inspects
the mixer state, the button state is already "off", so the application
doesn't get enough information about what happened?

If buttons are exposed as kcontrols, I suppose "Headphone Button N"
would be a fine name.

-- 
Tanu
