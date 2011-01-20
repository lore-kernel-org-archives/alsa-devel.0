From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] ECI: input: introduce ECI accessory
	input driver
Date: Thu, 20 Jan 2011 00:11:18 -0800
Message-ID: <20110120081117.GB2498@core.coreip.homeip.net>
References: <1295438816-27937-1-git-send-email-tapio.vihuri@nokia.com>
	<1295438816-27937-2-git-send-email-tapio.vihuri@nokia.com>
	<20110119174412.GB29107@core.coreip.homeip.net>
	<1295510248.26257.7.camel@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AAD61037E3
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 09:11:26 +0100 (CET)
Received: by ywe10 with SMTP id 10so100782ywe.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 00:11:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295510248.26257.7.camel@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tapio Vihuri <tapio.vihuri@nokia.com>
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 09:57:28AM +0200, Tapio Vihuri wrote:
> On Wed, 2011-01-19 at 09:44 -0800, ext Dmitry Torokhov wrote:
> > Hi Tapio,
> > 
> > On Wed, Jan 19, 2011 at 02:06:54PM +0200, tapio.vihuri@nokia.com wrote:
> > > +
> > > +	for (; key->type != KE_END; key++) {
> > > +		switch (key->type) {
> > > +		case KE_KEY:
> > > +			__set_bit(key->keycode, eci->acc_input->keybit);
> > > +			break;
> > > +		case KE_SW:
> > > +		case KE_VSW:
> > > +			__set_bit(key->keycode, eci->acc_input->swbit);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > 
> > Is this still needed? I believe sparse_keymap_setup() below shoudl take
> > care of this...
> > 
> > > +	__set_bit(EV_KEY, eci->acc_input->evbit);
> > > +	__set_bit(EV_SW, eci->acc_input->evbit);
> > > +	__set_bit(EV_REP, eci->acc_input->evbit);
> > > +
> > > +	err = sparse_keymap_setup(eci->acc_input, eci_keymap, NULL);
> > > +	if (err)
> > > +		goto err_free_dev;
> > > +
> > 
> 
> Hi Dmitry.
> 
> Thanks for pointing this out, as we have sparse keymap, we should use
> it :)
> 
> How about KE_VSW case ? Shouldn't it be in the sparse_keymap_setup {}
> also ?
> 

Indeed. Does the patch below fix it?

Thanks.

-- 
Dmitry

Input: sparse-keymap - fix KEY_VSW handling in sparse_keymap_setup

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We were forgetting to set up device capabilities for KEY_VSW entries.

Reported-by: Tapio Vihuri <tapio.vihuri@nokia.com> 
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/sparse-keymap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index a29a7812..7729e54 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -201,6 +201,7 @@ int sparse_keymap_setup(struct input_dev *dev,
 			break;
 
 		case KE_SW:
+		case KE_VSW:
 			__set_bit(EV_SW, dev->evbit);
 			__set_bit(entry->sw.code, dev->swbit);
 			break;
