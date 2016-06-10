From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: ASoC: Machine Driver Interaction with Codec Drivers
Date: Fri, 10 Jun 2016 09:37:10 +0530
Message-ID: <20160610040709.GW16910@localhost>
References: <0BE0E679-A120-4330-8291-315750457145@xenotropic.com>
 <57586E79.4010309@metafoo.de> <s5hinxihetz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 350182614A1
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2016 06:00:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hinxihetz.wl-tiwai@suse.de>
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
Cc: Jeremy McDermond <mcdermj@xenotropic.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2016 at 11:49:28AM +0200, Takashi Iwai wrote:
> On Wed, 08 Jun 2016 21:14:01 +0200,
> Lars-Peter Clausen wrote:
> > 
> > Hi,
> > 
> > No this is currently not really supported. There were some ideas for this a
> > long long time ago, but it never got implemented. And today basically
> > everybody takes care of hiding the controls from userspace.
> > 
> > That does not mean it does not make sense to have such a feature, but it
> > needs somebody with a motivation to implement it.
> 
> The devils live in details.  Actually a primary question is in which
> level we should cover it.  For example, can we disable DAPM pins from
> the machine driver?  This will reduce not only kctls but DAPM paths.
> Or should we mark kctls just as invisible?  Or, would it be suitable
> rather to hide such a thing in user-space?

Today codecs give DAPM graph but that is not linked in kctls. If we do that,
then DAPM can hide un-connected graphs!

For SKL DSP modules, we have modelled kctls in DAPM using PGA as we have to
enable/disable modules, so for DSP at least we can do this :)

So simpler might be to add dummy widgets to kctls by drivers and then hide.
Or we can have extended graph which has "extra" graph which show kctls to
graph links.

Thanks
-- 
~Vinod
