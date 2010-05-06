From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2] ASoC: tlv320aic3x: Add platform data and
	reset gpio handling
Date: Thu, 6 May 2010 11:09:34 +0300
Message-ID: <201005061109.34734.peter.ujfalusi@nokia.com>
References: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 949EE245DD
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 10:09:43 +0200 (CEST)
In-Reply-To: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 05 May 2010 13:02:03 ext Jarkko Nikula wrote:
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> =

> ---
> =

> v2:
> =

> - Removed added regulator_bulk_disable brain fart from aic3x_i2c_probe
> - Added comment to gpio_reset number in aic3x_pdata

Would have been nice to have a commit message for this just in case.
Something like this would do:
Handle the reset GPIO within the codec driver in order to follow the startu=
p =

protocol for the tlv320aic3x codecs.

Can you Liam add this message (if Jarkko agrees)?

I can give my:
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Or
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Whichever you feel appropriate in case of the tlv320aic3x codec driver.

-- =

P=E9ter
