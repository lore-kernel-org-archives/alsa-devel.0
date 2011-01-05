From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: regarding references taken on platform and codec
 driver modules
Date: Wed, 5 Jan 2011 22:49:32 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C119C092@bgsmsx502.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
	<20110103155454.GE6783@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
	<20110103163532.GB7370@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51BC3@bgsmsx501.gar.corp.intel.com>
	<20110104154825.GF24774@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BFABE47@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id C8309244CA
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 18:19:38 +0100 (CET)
In-Reply-To: <98769532B4BB14429434178695419EAE053BFABE47@bgsmsx501.gar.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> 
> >> Please provide your comments on the patch below that makes this change
> >
> >Please follow Documentation/SubmittingPatches - remember to CC
> >maintainers (I've added Liam) and don't bury your patches in the middle
> >of another e-mail.
> >
> I have sent the patch in a separate email.
I seem to have hit another instance of where references are kept wrongly.

During the testing codec driver probe was failing and this results in wrong
reference of platform driver .

On investigating the issue is in soc_bind_dai_link()

It takes the reference of cpu_dai and adds the dai in the runtime structure.
But since the codec was not found these references are kept and modules cant be
unloaded.

Now thinking on this and other reference patch recently applied, IMO we can
instead of taking the module reference check if cpu_dai is probed.
If probed then only go ahead otherwise return error

Something like this
@@ -1238,9 +1238,10 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
        list_for_each_entry(cpu_dai, &dai_list, list) {
                if (!strcmp(cpu_dai->name, dai_link->cpu_dai_name)) {

-                       if (!try_module_get(cpu_dai->dev->driver->owner))
+                       if (!cpu_dai->probed)
		                     return -ENODEV;

Would this be right thing to do? My logic is that we should be relying on probed
to see references (as while marking probed we do take the reference).
I have tested with both false and positive case worked for me on both counts.

If this looks fine I will send a proper patch

~Vinod
