From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ak4642: show error if register write fails
Date: Tue, 11 Mar 2014 15:20:11 +0100
Message-ID: <531F1B9B.5050400@metafoo.de>
References: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140310234038.GE28112@sirena.org.uk> <531EF106.3020809@codethink.co.uk>
 <20140311112112.GP28112@sirena.org.uk> <531F16DB.30200@metafoo.de>
 <531F1ADE.3000409@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-090.synserver.de
 [212.40.185.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7CD261A5C
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 15:25:34 +0100 (CET)
In-Reply-To: <531F1ADE.3000409@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On 03/11/2014 03:17 PM, Ben Dooks wrote:
> On 11/03/14 13:59, Lars-Peter Clausen wrote:
>> On 03/11/2014 12:21 PM, Mark Brown wrote:
>>> On Tue, Mar 11, 2014 at 11:18:30AM +0000, Ben Dooks wrote:
>>>> On 10/03/14 23:40, Mark Brown wrote:
>>>
>>>>> Two things here.  One is that this should be a dev_err() and the other
>>>>> is that if this is worth doing shouldn't it just be in the core - I see
>>>>> nothing driver specific here?
>>>
>>>> Sorry, didn't see a device in "struct snd_soc_codec *codec" so I went
>>>> for a printk (although it was pr_info instead of pr_err).
>>>
>>> codec->dev.
>>>
>>>> If you think that changing the two snd_soc calls to print errors
>>>> when anything bad happens then that would also be a good idea then
>>>> I can send a patch for that.
>>>
>>> That would be better, yes.
>>
>> In my opinion it's better to pass the error on to the upper levels. E.g.
>> if userspace opens the PCM device and there is an IO error in the
>> startup callback then that error should be passed on to the userspace
>> application rather than doing a out of band error reporting and adding a
>> entry to the kernel log.
>
>  From a grep, there doesn't seem to be much in the way of error
> checking in a number of the codec drivers.
>
>

That doesn't mean it's the right thing to do no error checking ;)
