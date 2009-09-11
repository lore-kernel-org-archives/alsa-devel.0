From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] RFC: ASoC: Davinci: Fix data_type divide
 by zero
Date: Fri, 11 Sep 2009 14:27:18 -0700
Message-ID: <4AAAC0B6.2010904@boundarydevices.com>
References: <1252547830-16585-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090911103139.GA19204@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C372438C
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 23:27:29 +0200 (CEST)
In-Reply-To: <20090911103139.GA19204@sirena.org.uk>
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
Cc: khilman@deeprootsystems.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Sep 09, 2009 at 06:57:10PM -0700, Troy Kisky wrote:
> 
>> This applies on top of my last patchset to Kevin's temp/asoc branch
> 
> Could you please respin against what's in for-2.6.32 - this ought to get
> fixed there but the other changes will need to wait for 2.6.33.
> 
>>  struct davinci_mcbsp_dev {
>> +	/*
>> +	 * dma_params must be first because rtd->dai->cpu_dai->private_data
>> +	 * is cast to an array of struct davinci_pcm_dma_params ** in
>> +	 * davinci_pcm_open.
>> +	 */
> 
> Is it not possible to deal with this by going through the types
> properly?  The comment sets off all sorts of alarm bells.
> 

private_data will be either struct davinci_mcbsp_dev or
struct davinci_audio_dev


So, I moved dma_params to be 1st in both structures and added
a comment so that noone will move it.

Btw, I'm about to submit another rev of this against your for32
branch. But your branch currently give compile errors, so it
my compile test just doesn't generate new errors.

Troy
