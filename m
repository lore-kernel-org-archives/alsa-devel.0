From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/2] ASoC: DAPM: Add private data
	pointer for DAPM widget
Date: Mon, 22 Aug 2011 16:33:20 +0300
Message-ID: <1508700.DYiRuuCFX2@barack>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1313739679-8975-2-git-send-email-peter.ujfalusi@ti.com>
	<20110820070219.GC5011@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DB1724559
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 15:33:21 +0200 (CEST)
In-Reply-To: <20110820070219.GC5011@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Saturday 20 August 2011 09:02:20 Mark Brown wrote:
> On Fri, Aug 19, 2011 at 10:41:18AM +0300, Peter Ujfalusi wrote:
> > Support for using custom private data assigned
> > per DAPM widget.
> =

> If we're adding this we should probably go the accessor route like we do
> with the driver data for the CODECs.

Something like:

static inline void *snd_soc_widget_get_pdata(struct snd_soc_dapm_widget *w)
{
        return w->private_data;
}

static inline void snd_soc_widget_set_pdata(struct snd_soc_dapm_widget *w,
			void *data)
{
        w->private_data =3D data;
}

Another option at the moment is that I create global variable within the om=
ap-
mcpdm.c, so I can have access to the mcpdm within the dapm event handler.

-- =

P=E9ter
