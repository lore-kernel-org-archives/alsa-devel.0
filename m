From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 09:11:28 -0800
Message-ID: <CA+55aFyrseO4ywbxeQ90qYdHKnDbnOm6vEEHvTLo61S7oZRWuQ@mail.gmail.com>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de> <20171115113742.27b2nvfsbtvv7gfs@sirena.org.uk>
 <s5ha7zn69e7.wl-tiwai@suse.de> <20171115152411.GI3187@localhost>
 <355efb61-f59d-05c3-3715-86e56df1ee7f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 1099E266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 18:11:30 +0100 (CET)
Received: by mail-it0-f54.google.com with SMTP id b5so2560272itc.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 09:11:30 -0800 (PST)
In-Reply-To: <355efb61-f59d-05c3-3715-86e56df1ee7f@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 8:19 AM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> The bucketization you are talking about is already implemented in practice,
> when you select the SOC options you have a set of machine drivers that show
> up in the menu options.

So what the network drivers do - because they have an absolutely
sh*tload of drivers - is to have vendor-specific helper "gatekeeping"
options that do not affect the code in *any* way, but only affect the
config option dependencies for that vendor.

And those gatekeeping options are then "default y", so that when you
add a new gatekeeper, you do not limit people by default - but you
also don't add any actual code to the kernel!

So for example, you'll see things like this:

    config NET_VENDOR_ADAPTEC
            bool "Adaptec devices"
            default y
            depends on PCI

    if NET_VENDOR_ADAPTEC

    ... all the ADAPTEC network driver configs go here,
    ... even if right now there's only one

    endif # NET_VENDOR_ADAPTEC

and note how CONFIG_NET_VENDOR_ADAPTEC does not show up in the source
AT ALL, except as a "ok, the make recurses into the adapted
subdirectory".

So NET_VENDOR_ADAPTEC is purely used to make the configuration choice
easy. Instead of seeing a million different network driver questions,
you see a hundred different network driver _vendor_ choices, and then
only if you enable a vendor will you see the individual drivers.

So by default, all vendors are enabled, so "make oldconfig" etc works
fine, but if you are a human that goes through things by hand, you can
just say 'n' to the vendor, and not have to say 'n' to the fifteen
different (or sometimes just one - the ADAPTEC example really was a
bad choice) individual drivers.

That actually works quite well. And exactly because there is no actual
code that gets enabled by these vendor choices, they can be enabled by
default, so that when you add a new vendor gatekeeper and move an old
config option to depend on that vendor, it doesn't affect "make
oldconfig" negatively.

(Networking didn't always do this, but they've been pretty consistent
about it the last many years - exactly because networking used to be a
nightmare just because there are _so_ many different random network
cards).

            Linus
