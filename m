From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Mon, 16 Nov 2015 14:05:47 +0000
Message-ID: <20151116140547.GD18889@ck-lbox>
References: <20150914115255.GE11200@ck-lbox> <20151012090045.GA7448@amd>
 <20151012154715.GF4238@sirena.org.uk> <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk> <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk> <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk> <20151114175915.GA20429@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id CE8C426047B
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 15:21:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151114175915.GA20429@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 14, 2015 at 06:59:16PM +0100, Pavel Machek wrote:
> Hi!
> 
> > If you're asking about the regulator API or embedded ALSA both of those
> > are me but there are other things in here - the driver you're working
> > with and the MFD core at least.  At the minute I'm not convinced that
> > the problem here isn't just that the MFD and/or MFD core hasn't set up
> > the mappings to the child devices properly.
> 
> Ok, good. I don't understand how the things are expected to fit
> together. See above. I believe SND_SOC_ macros should have another
> argument "device", or maybe regulator names should have "device" name
> embedded in them.

Effectively the device is passed it is just implicit. If you look
where the regulator is actually registered in soc-dapm.c

	case snd_soc_dapm_regulator_supply:
		w->regulator = devm_regulator_get(dapm->dev, w->name);
		if (IS_ERR(w->regulator)) {

You see we are requesting the regulator with the dapm device,
which will correspond to the CODEC.

Thanks,
Charles
