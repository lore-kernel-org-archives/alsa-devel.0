From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] ECI: input: introduce ECI accessory
	input driver
Date: Wed, 19 Jan 2011 09:44:12 -0800
Message-ID: <20110119174412.GB29107@core.coreip.homeip.net>
References: <1295438816-27937-1-git-send-email-tapio.vihuri@nokia.com>
	<1295438816-27937-2-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 86A63103874
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 18:44:21 +0100 (CET)
Received: by pxi20 with SMTP id 20so240058pxi.38
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 09:44:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295438816-27937-2-git-send-email-tapio.vihuri@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tapio.vihuri@nokia.com
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi Tapio,

On Wed, Jan 19, 2011 at 02:06:54PM +0200, tapio.vihuri@nokia.com wrote:
> +
> +	for (; key->type != KE_END; key++) {
> +		switch (key->type) {
> +		case KE_KEY:
> +			__set_bit(key->keycode, eci->acc_input->keybit);
> +			break;
> +		case KE_SW:
> +		case KE_VSW:
> +			__set_bit(key->keycode, eci->acc_input->swbit);
> +			break;
> +		}
> +	}
> +

Is this still needed? I believe sparse_keymap_setup() below shoudl take
care of this...

> +	__set_bit(EV_KEY, eci->acc_input->evbit);
> +	__set_bit(EV_SW, eci->acc_input->evbit);
> +	__set_bit(EV_REP, eci->acc_input->evbit);
> +
> +	err = sparse_keymap_setup(eci->acc_input, eci_keymap, NULL);
> +	if (err)
> +		goto err_free_dev;
> +

Haven't looked at the rest yet...

Thanks.

-- 
Dmitry
