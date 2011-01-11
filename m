From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH 2/4] ASoC sst v2: Add mid platform driver
Date: Tue, 11 Jan 2011 14:33:43 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C0A9D8B6@bgsmsx501.gar.corp.intel.com>
References: <1294152392-8914-1-git-send-email-vinod.koul@intel.com>
	<20110106141215.GC6328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B9FB224591
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 10:04:05 +0100 (CET)
In-Reply-To: <20110106141215.GC6328@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>
>> +	return stream->stream_info.buffer_ptr;
>
>I thought you were going to clarify that this isn't exactly a pointer?
>
This variable in declared in Intel sst driver which is in Staging tree. We will
first send a patch to Greg and once that applied, we will send a change to you
for renaming the variable.

-Harsha
