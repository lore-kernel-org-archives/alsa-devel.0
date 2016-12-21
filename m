From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/2] ucm: Automatically load the best
 config file based on the card long name
Date: Wed, 21 Dec 2016 16:24:44 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A04E74@shsmsx102.ccr.corp.intel.com>
References: <1482325768-20084-1-git-send-email-mengdong.lin@linux.intel.com>
 <399bde54-dc72-4ce1-a2d2-5c6e4b958f5c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D371266E24
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 17:25:08 +0100 (CET)
In-Reply-To: <399bde54-dc72-4ce1-a2d2-5c6e4b958f5c@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Wednesday, December 21, 2016 10:47 PM
> 
> On 12/21/16 7:09 AM, mengdong.lin@linux.intel.com wrote:
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> >
> > Intel DSP platform drivers are used by many different devices. For
> > user space to differentiate them, ASoC machine driver may include the
> > DMI info (vendor, product and board) in card long name. Possible card
> > long names
> > are:
> > broadwell-rt286-Dell Inc.-XPS 13 9343-0310JH broadwell-rt286-Intel
> > Corp.-Broadwell Client platform-Wilson Beach SDS bytcr-rt5640-ASUSTeK
> > COMPUTER INC.-T100TA-T100TA bytcr-rt5651-Circuitco-Minnowboard Max
> D0
> > PLATFORM-MinnowBoard MAX ...
> >
> > And user space can define configuration files including fields
> > separated by '.' as below:
> > broadwell-rt286
> > broadwell-rt286.Dell.XPS
> > bytcr-rt5640
> > bytcr-rt5640.ASUS.T100
> > bytcr-rt5651.MinnowboardMax
> > ...
> 
> It's weird to use a different naming convention in driver and userspace.
> Now the '.' is a separator?

Yes. Now '.' is a separator in user space. The code use it to separate each keyword for matching in the card long name. We can also use '.' as separators in kernel, it will not affect the matching. 

> > When being asked to load configuration file of a card, UCM will try to
> > find the card long name from the local machine, and then scan all
> > available configuration file names, search every field of config file
> > name in the card long name. The more characters match, the higher
> > score the file has. Finally, the file with the highest score will be
> > loaded to configure the sound card.
> 
> There are cases where we absolutely don't want to let users use a shorter
> name. T100 is terrible for example, it would work for T100TA, T100TAF,
> T00HA which are completely different platforms.
> 
> While the partial matching is elegant, I would err on the side of simplicity
> and keep the filename as reported by the driver. that way people just
> copy/paste the longname name and there are fewer opportunities for
> screwups. Yes the file names would be a tad long but we are not using DOS,
> are we?

The file names would be really long and machines have different product name can potentially use the same configuration file for DELL XPS 13 or 15(2014) and DELL XPS 13 or 15 (2015) although they have a slight different number in DMI product and board names. For such products, a simple configuration name as "broadwell-rt286.Dell.XPS" can serve them all.

For the AUS T100 family, we could define different configuration files as below:
bytcr-rt5640.ASUS.T100TA
bytcr-rt5640.ASUS.T100TAF
bytcr-rt5640.ASUS.T100HA

They will have different scores, so UCM can choose the best one.

Thanks
Mengdong
