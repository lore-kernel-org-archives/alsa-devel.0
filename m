From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][sound/soc/fsl/mpc8610_hpcd.c] duplicate
 strcasecmp test for "rj-master" in mpc8610_hpcd_probe()
Date: Mon, 04 Feb 2008 17:17:29 -0600
Message-ID: <47A79D09.6090806@freescale.com>
References: <47A77EB2.6070703@tiscali.nl> <20080204231114.GA7842@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C6A524357
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 00:17:35 +0100 (CET)
In-Reply-To: <20080204231114.GA7842@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <12o3l@tiscali.nl>, Timur Tabi <timur@freescale.com>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Feb 04, 2008 at 10:08:02PM +0100, Roel Kluin wrote:
>> In linus' git tree I found this problem. Is it also in the alsa tree?
>> please confirm it's the right fix. The patch was not yet tested.
> 
> Timur, this looks like a good catch?

Yes, thank you!  The change below should be made.

> 
>> --
>> duplicate test for "rj-master"
>>
>> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
>> ---
>> diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
>> index f26c4b2..a00aac7 100644
>> --- a/sound/soc/fsl/mpc8610_hpcd.c
>> +++ b/sound/soc/fsl/mpc8610_hpcd.c
>> @@ -314,9 +314,9 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
>>  	} else if (strcasecmp(sprop, "lj-master") == 0) {
>>  		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
>>  		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
>>  		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
>> -	} else if (strcasecmp(sprop, "rj-master") == 0) {
>> +	} else if (strcasecmp(sprop, "rj-slave") == 0) {
>>  		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
>>  		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
>>  		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
>>  	} else if (strcasecmp(sprop, "rj-master") == 0) {
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Timur Tabi
Linux kernel developer at Freescale
