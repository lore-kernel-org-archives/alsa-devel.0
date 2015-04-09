From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Do not create debugfs
	directory
Date: Thu, 09 Apr 2015 09:56:18 +0200
Message-ID: <552630A2.3060400@metafoo.de>
References: <1428513684-26577-1-git-send-email-festevam@gmail.com>
 <20150409074953.GA62585@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BD5A261A3B
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 09:56:18 +0200 (CEST)
In-Reply-To: <20150409074953.GA62585@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On 04/09/2015 09:49 AM, Nicolin Chen wrote:
> On Wed, Apr 08, 2015 at 02:21:24PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Since commit 81c7cfd1b22a0 ("ASoC: Move debugfs registration to the
>> component level") ASoC core code deals with registering debugfs, so we
>> should not be creating the debugfs directory locally in order to avoid
>> the following warning:
>>
>> fsl-ssi-dai 2028000.ssi: ASoC: Failed to create component debugfs directory
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v1:
>> - Only remove dir creation/remove as suggested by Mark Brown
>
>> diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
>> index 5469ffb..46cea84 100644
>> --- a/sound/soc/fsl/fsl_ssi_dbg.c
>> +++ b/sound/soc/fsl/fsl_ssi_dbg.c
>> @@ -142,22 +142,15 @@ static const struct file_operations fsl_ssi_stats_ops = {
>>
>>   int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
>>   {
>> -	ssi_dbg->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
>> -	if (!ssi_dbg->dbg_dir)
>> +	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO, NULL,
>> +						 ssi_dbg, &fsl_ssi_stats_ops);
>> +	if (!ssi_dbg->dbg_stats)
>>   		return -ENOMEM;
>>
>> -	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO,
>> -			ssi_dbg->dbg_dir, ssi_dbg, &fsl_ssi_stats_ops);
>
> It seems that dropping the dbg_dir and using NULL will make the stats
> become an orphan inside the debugfs. I am wondering if we can get the
> dbg_dir from the component so as to put this stats under the directory
> of SSIn as before.

That would be the right thing I guess. But the original code registers a 
top-level debugfs directory with the name of the device. Whereas the debugfs 
directory for the component is created in asoc/CARD_NAME/. I don't see how 
these two could collide? I think the patch is trying to fix the wrong thing, 
the issue for the collision is something else.

- Lars
