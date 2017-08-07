From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: compress: Remove duplicated code
Date: Mon, 7 Aug 2017 10:28:30 -0500
Message-ID: <9bebfae0-5fd2-bb44-18dd-d7c25f59f1b1@linux.intel.com>
References: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
 <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
 <20170807150714.e7aecqskfelp7h5z@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C5FA02672A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:28:33 +0200 (CEST)
In-Reply-To: <20170807150714.e7aecqskfelp7h5z@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/7/17 10:07 AM, Mark Brown wrote:
> On Mon, Aug 07, 2017 at 09:18:09PM +0800, Donglin Peng wrote:
>
>> The value of the variable new_name is assigned repeatedly.
>
>> @@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
>> *rtd, int num)
>>         }
>>
>>         /* check client and interface hw capabilities */
>> -       snprintf(new_name, sizeof(new_name), "%s %s-%d",
>> -                       rtd->dai_link->stream_name, codec_dai->name, num);
>> -
>
> Are you sure that this is the assignment that should be deleted, and if
> so why?  Note that it's both conditionally and unconditionally assigned
> later on...  Some words in the commit log about why this copy is removed
> would be helpful.

Thanks for the report. Yes, the logic escapes me as well, there were two 
separate changes from Liam and Richard Fitzgerald and I can't figure out 
why the reassignments of the variable new_name are required.
