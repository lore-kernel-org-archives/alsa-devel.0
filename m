From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/8] ASoC: SigmaDSP: Provide diagnostic
	error messages
Date: Fri, 25 Nov 2011 09:59:21 +0100
Message-ID: <4ECF58E9.9070903@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
	<1322138908-32127-6-git-send-email-lars@metafoo.de>
	<201111241232.43809.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-169.synserver.de (smtp-out-169.synserver.de
	[212.40.185.169])
	by alsa0.perex.cz (Postfix) with SMTP id B83AE103E9F
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 09:58:18 +0100 (CET)
In-Reply-To: <201111241232.43809.vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 06:32 PM, Mike Frysinger wrote:
> On Thursday 24 November 2011 07:48:25 Lars-Peter Clausen wrote:
>> +	if (crc != le32_to_cpu(ssfw_head->crc)) {
>> +		dev_err(&client->dev, "Failed to load firmware: Wrong crc checksum:" \
>> +			" expected %x got %x.\n",
> 
> it's my understanding that string constants should not be split
> -mike

I think it is fine here. You probably wouldn't grep for %x anyway.
