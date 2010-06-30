From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [RFC 04/16] ASoC: multi-component - TI CODECs
Date: Thu, 1 Jul 2010 01:09:34 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305A415C1@dbde02.ent.ti.com>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	<1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id F0D7224407
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 21:39:43 +0200 (CEST)
In-Reply-To: <1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Liam Girdwood
Sent: Friday, June 25, 2010 11:23 PM
To: alsa-devel@alsa-project.org
Cc: Mark Brown; Liam Girdwood
Subject: [alsa-devel] [RFC 04/16] ASoC: multi-component - TI CODECs

Move TI CODECs to multi-component

[...]
o codec cache can now be malloc()ed by core.

[...]

Hi Liam,

For the AIC3x codec I saw that sysfs entry was missing. Is the malloc()to be done in the evm file somewhere?

Regards,
Vaibhav
