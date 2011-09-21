From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 13:59:12 -0500
Message-ID: <1316631553.21546.3.camel@pbossart-Dell-N7010>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
	<1316566711.3872.24.camel@pbossart-Dell-N7010>
	<4E7987BF.8000206@canonical.com>
	<000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
	<4E79ECBA.3060705@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1738180031@HQMAIL01.nvidia.com>
	<1316626243.16197.7.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF1738180119@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id AA9AA24491
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 20:59:35 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1738180119@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Wu Fengguang' <fengguang.wu@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


> GeForce 520 (1 codec, up to 4 pins per, but 2 pins disabled):
> 
> [swarren@swarren-lx2 alsa-driver-build]$ sudo amixer -c1 controls | grep ELD
> numid=5,iface=PCM,name='ELD',device=3
> numid=10,iface=PCM,name='ELD',device=7
> 
> GeForce 200 series (4 codecs, 1 pin per):
> 
> [swarren@swarren-lx2 alsa-driver-build]$ sudo amixer -c2 controls | grep ELD
> numid=5,iface=PCM,name='ELD',device=3
> numid=10,iface=PCM,name='ELD',device=7
> numid=15,iface=PCM,name='ELD',device=8
> numid=20,iface=PCM,name='ELD',device=9
> 
> That looks pretty sane to me.

Excellent. Thanks for your time!

> It doesn't apply to ToT; it conflicts slightly with Takashi's recent
> ELD bytes cleanup.

Ah, yes. Haven't updated since kernel.org went down.

> 	pin_idx = kcontrol->private_value; 
> ...
> > +	if (pin_idx < 0) {
> > +		uinfo->count = 0;
> 
> I don't think you need that conditional. I'd just assume that pin_idx
> was set correctly when the control was created, and not create the
> control if that wasn't the case. At most, BUG_ON here?

Agree. All this was copy/pasted debug code in case I modified things.

> One question: How do we know that ucontrol is large enough to accept
> eld->eld_size; are all BYTES controls always big enough, or do we need
> a check here on ucontrol->value.bytes.size or something like that?

The ELD is limited to 256 bytes. Same as the size of a BYTES control.
