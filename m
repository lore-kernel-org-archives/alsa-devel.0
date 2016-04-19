From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: tlv320aix31xx: Add ACPI match for
 Lenovo 100S
Date: Tue, 19 Apr 2016 12:57:40 -0500
Message-ID: <57167194.2030803@linux.intel.com>
References: <1461081620-23378-1-git-send-email-hadess@hadess.net>
 <20160419164107.GY3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F13B26262A
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 19:57:44 +0200 (CEST)
In-Reply-To: <20160419164107.GY3217@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 04/19/2016 11:41 AM, Mark Brown wrote:
> On Tue, Apr 19, 2016 at 06:00:20PM +0200, Bastien Nocera wrote:
>
>> +static const struct acpi_device_id aic31xx_acpi_match[] = {
>> +	{ "10TI3100", 0 },
> An ACPI identifier that actually bears some resemblance to the name of
> the part, will wonders never cease!  :)
It's not a legit ACPI id but at least it's consistent with other BIOS. I 
see the same in a couple of DSDT I extracted. it'd be curious to see the 
schematics if you have them to help progress with Baytrail-CR support.
