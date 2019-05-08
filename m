From: Matt Flax <flatmax@flatmax.org>
Subject: Re: cs4265 : alsactl store and "C data buffer" fails
Date: Wed, 8 May 2019 16:34:23 +1000
Message-ID: <50359ba4-cd36-5712-af4c-ad175df94ef3@flatmax.org>
References: <bdc0a30f-c6f3-8ccb-f556-1d1a6a68f3b9@flatmax.org>
 <1c0e5dbe-d5d5-c505-3b62-77e5fab8ee3d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9672F80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:34:30 +0200 (CEST)
In-Reply-To: <1c0e5dbe-d5d5-c505-3b62-77e5fab8ee3d@ladisch.de>
Content-Language: en-AU
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens for your guidance.

It worked !!!

I have posted the patch.

On 7/5/19 4:08 pm, Clemens Ladisch wrote:
> Matt Flax wrote:
>> When alsactl store is run with a cs4265 chip, the following error occurs (from https://github.com/Audio-Injector/Ultra/issues/25) :
>>
>> $ sudo alsactl store
>> alsactl: get_control:256: Cannot read control '2,0,0,C Data Buffer,0': Input/output error
> This sounds like a bug in cs4265_readable_register(); try replacing CS4265_SPDIF_CTL2
> with CS4265_MAX_REGISTER.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
