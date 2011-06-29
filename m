From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc: how to enable micbias and codec power when
	headset inserted
Date: Wed, 29 Jun 2011 10:47:51 -0700
Message-ID: <20110629174742.GA13051@opensource.wolfsonmicro.com>
References: <12D0C12AF19E15409D57F22566E88EF5096B923298@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A82891038F0
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 22:55:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <12D0C12AF19E15409D57F22566E88EF5096B923298@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.cm>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2011 at 10:32:39PM +0530, Babu, Ramesh wrote:

> I have question on handling mic bias and codec bias when headset is inserted.
> When headset is inserted, the mic bias and codec bias should be ON, in order to get the
> button press interrupts from the headset.

> Do I need to have dapm path to achieve this?  

Use snd_soc_dapm_force_enable_pin() to force the micbias widget on and
_disable_pin() to turn it off again when the jack is removed.  You can
do this in response to a notification registered with the notifier chain
in the jack using snd_soc_jack_notifier_register().
