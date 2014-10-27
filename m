From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 8/8] ASoC: dapm: Use more aggressive
	caching
Date: Mon, 27 Oct 2014 13:10:23 +0100
Message-ID: <544E362F.2050100@metafoo.de>
References: <CAES_P+8Z2BO46XuLokSXsgfNQud3VfNTXKOno9VinTsM=cyXBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-141.synserver.de (smtp-out-141.synserver.de
 [212.40.185.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 553E82608C7
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 13:10:49 +0100 (CET)
In-Reply-To: <CAES_P+8Z2BO46XuLokSXsgfNQud3VfNTXKOno9VinTsM=cyXBQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/26/2014 08:29 PM, noman pouigt wrote:
>> E.g. imagine the following example:
>>
>>         A --> B ----.
>>                     v
>>        M --> N --> Z <-- S <-- R
>>                     |
>>                     v
>>                     X>
>>
>> Widget Z has multiple input paths, if any change was made that cause Z to be
>> marked as dirty the power state of Z has to be re-computed. This requires to
>> know the number of inputs and outputs of Z, which requires to know the
>> number of inputs and outputs of all widgets on all paths from or to Z.
>> Previously this meant re-computing all inputs and outputs of all the path
>> going into or out of Z. With this patch in place only paths that actually
>> have changed need to be re-computed.
> so suppose "B" was the widget which caused "Z" to be dirtied then with your
> patch only you will calculate A->B->N->Z ?

It will only re-compute the inputs and outputs on those path that may have 
changed. E.g. if Z is a mixer and the switch between N and Z is changed it 
will only re-compute the number of outputs for M and N and the number of 
outputs for Z and X. But keep the cached numbers for all other widgets.

>
> Is my understanding right?
>
> A->B->C
>              |
>              v
>             G->P
>              v
>              |
> D->E->F
>
> What will happen in the above diagram if P gets dirtied?

That depends on the reason why it was marked as dirty. Different operations 
have different impacts on the validity of the cached input/output numbers.

This series does not change which widgets get mark as dirty or how dirty 
widgets are handled. It introduces caching for the number of connected paths 
that go to a sink and the number of paths that come from source.

- Lars
