From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Fri, 30 Nov 2007 18:33:53 +0100
Message-ID: <47504981.2080804@keyaccess.nl>
References: <474E1189.9030701@keyaccess.nl>	<200711290920.05010.bjorn.helgaas@hp.com>	<474EF871.7090400@gmail.com>	<200711291230.24323.bjorn.helgaas@hp.com>	<474F5DFC.6040507@keyaccess.nl>	<s5h7ik0f6eq.wl%tiwai@suse.de>	<4750434F.2080603@keyaccess.nl>
	<s5hk5nzem22.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 20898103800
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 18:34:30 +0100 (CET)
In-Reply-To: <s5hk5nzem22.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 30-11-07 17:27, Takashi Iwai wrote:

> At Fri, 30 Nov 2007 18:07:27 +0100,
> Rene Herman wrote:

>> By the way, eventually I'd in fact probably like to move some of the drivers 
>> that now still support legacy ISA over to PnP only. After all, chips such as 
>> the CMI8330, CS4232+, ES1869+ and OPL3SA2 _are_ PnP only chips.
>>
>> Certainly for CS4232+ and ES1869+ that can't be done currently as we know 
>> people are in fact using isapnp=0 to work around PnPBIOS issues but from the 
>> previous report there it seemed that might actually just consist of the BIOS 
>> claiming no resource change is possible, which pnp_activate_dev (through 
>> pnp_autoconfig_dev) insist on anyway. This would be something to fix inside 
>> PnP instead...
> 
> Well, I'm not sure about that.  Certainly there are some users that
> use isapnp=no with explicit parameters.

Yes, currently, but as said, we might be able to al least make sure they 
don't _need_ to do that at the PnP layer after which it becomes somewhat 
debatable at least. But yes, sure, not now, once, maybe, perhaps, ...

>> Anyways, here's just a further Documentation update. You once told me to 
>> start new threads for patches, but that seems clumsy now... :-|
> 
> Thanks.  It seems that people do care more on explanations about the
> removal of options.  Could you add that, too?
> Just mention about sysfs as alternative way to change the
> parameters...

Yes. Documentation/pnp.txt wants to be a little more verbose after which 
ALSA documentation can refer to it. I'll cook something up...

Rene.
