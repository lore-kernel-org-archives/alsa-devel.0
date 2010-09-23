From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: Clean up the CODEC device as
 well as the board for SMDK WM9713
Date: Thu, 23 Sep 2010 15:56:14 +0100
Message-ID: <20100923145614.GJ25663@rakim.wolfsonmicro.main>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BA4A10394F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 16:56:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 23, 2010 at 11:53:00PM +0900, Jassi Brar wrote:
> On Thu, Sep 23, 2010 at 11:40 PM, Mark Brown

> > =A0static void __exit smdk_exit(void)
> > =A0{
> > =A0 =A0 =A0 =A0platform_device_unregister(smdk_snd_ac97_device);
> > + =A0 =A0 =A0 platform_device_unregister(smdk_snd_wm9713_device);
> > =A0}
> >
> > =A0module_init(smdk_init);

> I think we need more than this to make module load/unload/load work.
> Like the soc-audio device added. Wouldn't that spoil the party next time
> the module is tried to loaded ?

Yes, the soc-audio device does need to be unregistered - it's the
smdk_snd_ac97_device that was already being unregistered here.
