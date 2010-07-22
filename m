From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 14:07:18 +0300
Message-ID: <201007221407.18882.peter.ujfalusi@nokia.com>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<201007221357.16840.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A4BB1039A8
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 13:07:52 +0200 (CEST)
In-Reply-To: <201007221357.16840.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Takashi Iwai <tiwai@suse.de>, "Aaltonen Matti.J (Nokia-MS/Tampere)" <matti.j.aaltonen@nokia.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

to give Takashi the context ;)

On Thursday 22 July 2010 13:57:16 Ujfalusi Peter (Nokia-MS/Tampere) wrote:
> So let's ask Takashi:
> Is it possible to use the constraint API for placing HALF_DUPLEX on a
> stream (modifying bits in the info_flags)?

Is there a clean way to do:

+       switch (wl1273->mode) {
+       case WL1273_MODE_BT:
+               pcm->info_flags &=3D ~SNDRV_PCM_INFO_HALF_DUPLEX;
+               break;
+       case WL1273_MODE_FM_RX:
+               if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+                       pr_err("Cannot play in RX mode.\n");
+                       return -EINVAL;
+               }
+               pcm->info_flags |=3D SNDRV_PCM_INFO_HALF_DUPLEX;
                 ^
                 This

+               break;
+       case WL1273_MODE_FM_TX:
+               if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
+                       pr_err("Cannot capture in TX mode.\n");
+                       return -EINVAL;
+               }
+               pcm->info_flags |=3D SNDRV_PCM_INFO_HALF_DUPLEX;
                 ^
                 and this

+               break;
+       default:

with for example the ALSA constraint API?

The info_flags are modified at stream open time.

Thanks, =

P=E9ter
