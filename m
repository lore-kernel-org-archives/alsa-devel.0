From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: Add surface3 entry in
	CHT-RT5645 machine
Date: Wed, 20 Jul 2016 09:28:35 +0530
Message-ID: <20160720035834.GH9681@localhost>
References: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
 <1467972591-29175-4-git-send-email-vinod.koul@intel.com>
 <1468940184.6761.36.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D94265885
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 05:51:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1468940184.6761.36.camel@hadess.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>
Cc: alsa-devel@alsa-project.org, Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 19, 2016 at 04:56:24PM +0200, Bastien Nocera wrote:
> > +	/* fixup codec name based on HID */
> > +	i2c_name =3D sst_acpi_find_name_from_hid(mach->id);
> > +	if (i2c_name !=3D NULL) {
> > +		snprintf(cht_rt5640_codec_name, sizeof(cht_rt5640_codec_name),
> > +			"%s%s", "i2c-", i2c_name);
> > +		cht_dailink[dai_index].codec_name =3D cht_rt5640_codec_name;
> =

> FWIW, I get:
> sound/soc/intel/boards/cht_bsw_rt5645.c: In function 'snd_cht_mc_probe':
> sound/soc/intel/boards/cht_bsw_rt5645.c:391:37: warning: 'dai_index' may =
be used uninitialized in this function [-Wmaybe-uninitialized]
> =A0=A0=A0cht_dailink[dai_index].codec_name =3D cht_rt5640_codec_name;
> =A0=A0=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~

Yeah I notice them a bit later. The fixes are already in mark's-next.

-- =

~Vinod
