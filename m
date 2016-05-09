From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/3] ASoC: da7219: Convert driver to use
 generic device/fwnode functions
Date: Mon, 9 May 2016 12:05:56 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D463C6A3@SW-EX-MBX01.diasemi.com>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <4783487c3caa1d66f0a1d5b25c9b341aee1118e4.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <20160506122643.GS6292@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D463C2EF@SW-EX-MBX01.diasemi.com>
 <20160506160536.GU6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.147])
 by alsa0.perex.cz (Postfix) with ESMTP id C4E0C2607C8
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 14:05:58 +0200 (CEST)
In-Reply-To: <20160506160536.GU6292@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

On May 06, 2016, 17:06, Mark Brown wrote:

> No, not really - your DT is fairly unusual in how it's done and the lack
> of ACPI helpers is not a good sign on that side.  The _DSD things are
> really only supposed to work for simple properties on devices.

It's unusual in that there's a child node ("da7219_aad") of the device node, to
encapsulate AAD specific information. The properties inside though are data only
and simple. Actually, as I read it this is exactly the kind of thing that the
'Hierarchical Data Extension UUID For _DSD' is for.

> > The intention was to just match against DT or ACPI and nothing else, so that
> > didn't feel generic enough to be pushed into the fwnode framework. However
> > I will take another look.
> 
> That's currently the entire set of things that fwnode supports so...

I believe there's the FWNODE_PDATA type as well so 3 things, although I assume
that this is to be used longer term instead of the old fashioned platform
data mechanism, for built-in properties. Right now though I don't see much
actual usage of this.
