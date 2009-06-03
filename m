From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: *SPAM* Re: Please help in adding ams-delta support
	to ASoC
Date: Wed, 3 Jun 2009 08:28:06 +0300
Message-ID: <200906030828.06933.peter.ujfalusi__1903.65789826519$1244007045$gmane$org@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090601210413.7678bf42.jhnikula@gmail.com>
	<4A25040A.4050506@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A25040A.4050506@tis.icnet.pl>
Content-Disposition: inline
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Janusz,

On Tuesday 02 June 2009 13:50:50 ext Janusz Krzysztofik wrote:
> Hi Jarkko,
>
> Jarkko Nikula wrote:
> > Is the older implementation working at commit
> > d8376cc482b241701f7606c81ad578b90853e175 in linux-omap, i.e. last
> > commit before their removal?
>
> I have managed to check with that revision this morning and yes, the
> driver is working.
>
> I'll try you other suggestions as soon as I get back home.

Looking at the code at commit: d8376cc482b241701f7606c81ad578b90853e175 on =
l-o =

the comment about the need for the call the omap_stop_dma puzzled me.
Can you try something like this:

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6454e15..2df1792 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -67,6 +67,7 @@ static void omap_pcm_dma_irq(int ch, u16 stat, void *data)
                spin_lock_irqsave(&prtd->lock, flags);
                if (prtd->period_index >=3D 0) {
                        if (++prtd->period_index =3D=3D runtime->periods) {
+                               omap_stop_dma(prtd->dma_ch);
                                prtd->period_index =3D 0;
                                omap_start_dma(prtd->dma_ch);
                        }
@@ -191,6 +192,7 @@ static int omap_pcm_trigger(struct snd_pcm_substream =

*substream, int cmd)
        case SNDRV_PCM_TRIGGER_START:
        case SNDRV_PCM_TRIGGER_RESUME:
        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+               omap_stop_dma(prtd->dma_ch);
                prtd->period_index =3D 0;
                omap_start_dma(prtd->dma_ch);
                break;

This is on top of sound-2.6:topic/asoc, but l-o should not be that differen=
t.
Call the omap_stop_dma before actually starting the dma, and call stop also =

before restarting it.


-- =

P=E9ter
