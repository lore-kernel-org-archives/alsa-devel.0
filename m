From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to
	determine jack type
Date: Tue, 1 Feb 2011 19:05:26 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C0FE9A6C@bgsmsx501.gar.corp.intel.com>
References: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
	<20110131120826.GD5123@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE08C0FE9A4D@bgsmsx501.gar.corp.intel.com>
	<20110201132206.GE12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2775210394A
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 14:35:30 +0100 (CET)
In-Reply-To: <20110201132206.GE12743@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


>> I believe this should be part of codec driver that would make sure that it has
>> determined the right adc value and then call the function to find the jack type.
>
>This is not in general possible - there are generally AUXADCs in many
>devices, CPUs and PMICs both commonly have them, and the majority of
>them just take a reading when asked to do so.  Generic software needs to
>be able to handle this.
What if I add a field debouce to snd_soc_jack and machine driver needs to program
the value. The codec driver should wait for that time before reading the adc values
Will this help
