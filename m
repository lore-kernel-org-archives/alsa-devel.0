From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: core: Add API to use DMI name in
 sound card long name
Date: Wed, 21 Dec 2016 15:01:56 +0000
Message-ID: <1482332516.2554.103.camel@loki>
References: <cover.1482324245.git.mengdong.lin@linux.intel.com>
 <748589b74f8f4a6fefe7e545c21a6db5e71a74e1.1482324245.git.mengdong.lin@linux.intel.com>
 <9511f55d-8a49-7e32-7faf-9d3fa26820ca@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 42ADF266725
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 16:02:03 +0100 (CET)
In-Reply-To: <9511f55d-8a49-7e32-7faf-9d3fa26820ca@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-12-21 at 08:37 -0600, Pierre-Louis Bossart wrote:
> > +
> > +     /* Add flavour to dmi long name */
> > +     if (flavour) {
> > +             strncat(card->dmi_longname, "-",
> > +                     sizeof(card->snd_card->longname));
> > +             strncat(card->dmi_longname, flavour,
> > +                     sizeof(card->snd_card->longname));
> > +     }
> 
> how is the 'flavour' defined? This doesn't seem to come from the DMI 
> decode information? Is this for example intended to be used with
> quirks?


Yes, it's intended for identifying quirks, different firmwares, etc

Liam
