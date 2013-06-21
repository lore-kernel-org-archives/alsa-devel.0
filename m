From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: codecs: adau1701: switch to
 direct regmap API usage
Date: Fri, 21 Jun 2013 09:31:30 +0200
Message-ID: <51C40152.6060500@gmail.com>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-3-git-send-email-zonque@gmail.com>
 <51C4008C.20001@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D6B762654CB
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 09:30:57 +0200 (CEST)
Received: by mail-ee0-f43.google.com with SMTP id l10so4399909eei.2
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 00:30:57 -0700 (PDT)
In-Reply-To: <51C4008C.20001@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 21.06.2013 09:28, Lars-Peter Clausen wrote:
> On 06/20/2013 07:29 PM, Daniel Mack wrote:
>> The hardware I/O has to be open-coded due to registers of unequal sizes.
>> Other than that, the transition is straight forward.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks. One minor nitpick though.
> 
>> ---
> [...]
>> +	msgs[0].addr = client->addr;
>> +	msgs[0].len = sizeof(send_buf);
>> +	msgs[0].buf = send_buf;
>> +	msgs[0].flags = 0;
>> +
>> +	msgs[1].addr = client->addr;
>> +	msgs[1].len = size;
>> +	msgs[1].buf = recv_buf;
>> +	msgs[1].flags = I2C_M_RD | I2C_M_STOP;
> 
> We don't need to set a explicit stop flag for the last message in the transfer.
> 

Right. I'll send a v3 of the entire series. Hang on.
