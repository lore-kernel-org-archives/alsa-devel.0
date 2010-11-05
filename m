From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Decouple DAPM from CODECs
Date: Fri, 5 Nov 2010 09:20:08 +0200
Message-ID: <20101105092008.388e67de.jhnikula@gmail.com>
References: <20101101131322.GC22639@opensource.wolfsonmicro.com>
	<1288874285-16569-1-git-send-email-jhnikula@gmail.com>
	<20101105032919.GA12228@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 20741103840
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 08:19:50 +0100 (CET)
Received: by eyg24 with SMTP id 24so1552131eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 00:19:49 -0700 (PDT)
In-Reply-To: <20101105032919.GA12228@opensource.wolfsonmicro.com>
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
Cc: Wan@alsa-project.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, ZongShun <mcuos.com@gmail.com>, Mike Frysinger <vapier.adi@gmail.com>, Jassi@alsa-project.org, Kevin Hilman <khilman@deeprootsystems.com>, Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Cai <cliff.cai@analog.com>, Timur Tabi <timur@freescale.com>, Morimoto <morimoto.kuninori@renesas.com>, Kuninori@alsa-project.org, Manuel Lauss <manuel.lauss@googlemail.com>, Daniel Gloeckner <dg@emlix.com>, Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Ryan Mallon <ryan@bluewatersys.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Cliff@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Nov 2010 23:29:20 -0400
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Nov 04, 2010 at 02:38:05PM +0200, Jarkko Nikula wrote:
> > From: Liam Girdwood <lrg@slimlogic.co.uk>
> > 
> > Decoupling Dynamic Audio Power Management (DAPM) from codec devices is
> > required when developing ASoC further. Such as for other ASoC components to
> > have DAPM widgets or when extending DAPM to handle cross-device paths.
> 
> This looks good but won't apply without your DAPM locking change.  In a
> case like this where the patch is going to be applied on a different
> branch to the one the dependency is on it's usually best to let the
> merge get sorted out when the branches get merged.

Lets not take honor from Peter Ujfalusi who find the locking issue
in DAPM :-)

As this patch is huge, a small fixup below to those conflicting
lines (and only those) of patch file. That makes the patch to apply on
top of for-2.6.38 branch.


-- 
Jarkko
-------------------- fixup.diff --------------------
--- [PATCH]_ASoC__Decouple_DAPM_from_CODECs.orig	2010-11-05 09:14:14.000000000 +0200
+++ [PATCH]_ASoC__Decouple_DAPM_from_CODECs	2010-11-05 09:15:44.000000000 +0200
@@ -5707,9 +5707,9 @@
  	LIST_HEAD(up_list);
  	LIST_HEAD(down_list);
 @@ -903,7 +909,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
+ 	/* Check which widgets we need to power and store them in
  	 * lists indicating if they should be powered up or down.
  	 */
- 	mutex_lock(&card->dpw_mutex);
 -	list_for_each_entry(w, &codec->dapm_widgets, list) {
 +	list_for_each_entry(w, &dapm->widgets, list) {
  		switch (w->id) {
@@ -5800,9 +5800,9 @@
 +	pop_dbg(dapm->pop_time, "DAPM sequencing finished, waiting %dms\n",
 +		dapm->pop_time);
 +	pop_wait(dapm->pop_time);
- 	mutex_unlock(&card->dpw_mutex);
  
  	return 0;
+ }
 @@ -1037,9 +1043,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
  		return -ENOMEM;
