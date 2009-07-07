From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 3/13] Intel SST driver include	headers
Date: Tue, 7 Jul 2009 11:45:52 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC2264@bgsmsx501.gar.corp.intel.com>
References: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
	<20090703112951.GD19768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id DC10D1038A7
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:16:41 +0200 (CEST)
In-Reply-To: <20090703112951.GD19768@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Friday, July 03, 2009 5:00 PM
>To: Koul, Vinod
>Cc: alsa-devel@alsa-project.org; Harsha, Priya
>Subject: Re: [alsa-devel] [PATCH] [RFC 3/13] Intel SST driver include
>headers
>
>On Fri, Jul 03, 2009 at 12:32:25PM +0530, Vinod Koul wrote:
>
>> +struct snd_pmic_ops {
>> +	int (*set_input_dev) (int value);
>
>I'm not sure what pmic is an abbreviation for but I worry that using
>this abbreviation is likely to cause confusion - PMIC normally refers to
>a Power Management IC in embedded applications.

PMIC is indeed Power management IC. (In the platform, sound card components are embedded inside the PMIC.) I shall change the name to sound card to avoid confusion.
