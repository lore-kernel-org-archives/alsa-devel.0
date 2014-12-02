From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: core: Call mute for cpu dais as well
Date: Tue, 02 Dec 2014 20:26:54 +0100
Message-ID: <547E127E.6080408@metafoo.de>
References: <20141127161503.GA21893@mwanda>
 <32F4D3A311A1404B92CF923AFF38C3C52E12D4DA@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-009.synserver.de (smtp-out-013.synserver.de
 [212.40.185.13])
 by alsa0.perex.cz (Postfix) with ESMTP id F044626069A
 for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2014 20:26:44 +0100 (CET)
In-Reply-To: <32F4D3A311A1404B92CF923AFF38C3C52E12D4DA@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12/02/2014 06:13 PM, Babu, Ramesh wrote:
>> This is a semi-automatic email about new static checker warnings.
>>
>> The patch ae11601b80b9: "ASoC: core: Call mute for cpu dais as well"
>> from Oct 15, 2014, leads to the following Smatch complaint:
>>
>> sound/soc/soc-pcm.c:777 soc_pcm_prepare()
>> 	 error: we previously assumed 'cpu_dai->driver->ops' could be null
>> (see line 755)
>>
>> sound/soc/soc-pcm.c
>>     754
>>     755		if (cpu_dai->driver->ops && cpu_dai->driver->ops->prepare)
>> {
>>                      ^^^^^^^^^^^^^^^^^^^^ I don't think this can be NULL.  Probably
>> we should remove this check.
> Nope. ops can be NULL.

It can't. If it is the core will update it to point to null_dai_ops.

- Lars
