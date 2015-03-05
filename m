From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] SoC: Fix MAX98357A codec driver
	dependencies
Date: Thu, 05 Mar 2015 06:05:45 -0800
Message-ID: <54F862B9.1000103@roeck-us.net>
References: <1423689198-24034-1-git-send-email-linux@roeck-us.net>
 <20150212025515.GU2593@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F912606FB
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 15:05:58 +0100 (CET)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YTWPV-0030ur-8A
 for alsa-devel@alsa-project.org; Thu, 05 Mar 2015 14:05:57 +0000
In-Reply-To: <20150212025515.GU2593@finisterre.sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 02/11/2015 06:55 PM, Mark Brown wrote:
> On Wed, Feb 11, 2015 at 01:13:18PM -0800, Guenter Roeck wrote:
>> The max98357a driver depends on GPIOLIB. This may cause the following
>> build failure.
>
> Applied, thanks.  Please use subject lines matching the style for the
> subsystem.
>
Hi Mark,

I notice that the problem this patch is trying to fix is still seen in the
upstream kernel. Did the patch get lost after all, or is it still in the
queue ?

Thanks,
Guenter
