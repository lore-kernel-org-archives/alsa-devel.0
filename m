From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Mon, 3 Aug 2015 08:51:28 +0530
Message-ID: <20150803032128.GO29916@localhost>
References: <20150714150352.GW11162@sirena.org.uk> <55BC772C.50801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ACF226262A
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 05:19:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55BC772C.50801@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 01, 2015 at 09:37:16AM +0200, Lars-Peter Clausen wrote:
> On 07/14/2015 05:03 PM, Mark Brown wrote:
> > [...]
> > 
> > and please follow up to this mail with any topics you'd like to see
> > raised so we can start collecting them (probably another Google doc will
> > be forthcoming for them).
> 
> Full media controller integration for both ALSA and ASoC. How this can be
> used to export topology information to userspace and how to for example
> attach a specific volume control to a specific media controller entity. And
> maybe also how to de-duplicate similar functionality between DAPM and media
> controller.
The recently merged topology core allows us to 'send' the complete topology
information for a component to kernel drivers.

So with this we now we have two additional choices:
- assuming all components use topology framework, we don't need to query, we
  use the topology information available in usermode. Some more support to
  parse topology binary installed and show as controls in alsa-lib might be
  required here
- do a reverse path, based on dapm and control info (driver will need to add
  code for linking the two) we add a new reverse API, which tells us the
  topology information from kernel

-- 
~Vinod
