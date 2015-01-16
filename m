From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: alsa-lib support for compress offload
Date: Fri, 16 Jan 2015 11:22:45 +0000
Message-ID: <54B8F485.7090603@imgtec.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 871572604BE
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 12:22:46 +0100 (CET)
In-Reply-To: <s5hbnlzt3o2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/16/2015 10:34 AM, Takashi Iwai wrote:
> At Fri, 16 Jan 2015 09:52:58 +0000,
> Qais Yousef wrote:
>> Hi,
>>
>> As far as I understand I need to use something similar to tinycompress
>> to use alsa devices that supports compress offload. When I asked on
>> gstreamer list [1] about alsasink support for compress offload they said
>> yes. But I can see that gstalsasink.c [2] only uses the standard
>> alsa-lib api which AFAICT doesn't support compress offload.
>>
>> Did I misread the code and alsa-lib actually works with compress
>> offload? Gstreamer refers to the feature "passthrough" and associate it
>> with SPDIF[3], are they taking advantage of some other alsa feature that
>> looks like compress offload?
> It's a normal IEC958 passthrough, nothing to do with the compress
> offload.  And, no, we have no support for compress API in alsa-lib
> yet.  Just because no one submitted the patches.
>
>
> Takashi

Thanks. I haven't used alsa-lib before but I might be able to send the 
patches if I get guidance of what needs doing. Is the expected API 
similar/same to what provided by tinycompress[1]?

[1] 
http://git.alsa-project.org/?p=tinycompress.git;a=blob;f=include/tinycompress/tinycompress.h;h=03c396fccea5f2a176d24fd580ee6a447da657ec;hb=HEAD
