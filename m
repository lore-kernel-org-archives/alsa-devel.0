From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: strange code in pcm_route.c for 3 byte formats
Date: Mon, 20 Nov 2017 13:14:45 +0100
Message-ID: <0ca2bc15-c949-fc74-f587-0aae16c836d6@maciej.szmigiero.name>
References: <b5b7e7f2-ff97-11d0-1e72-c119842dd266@maciej.szmigiero.name>
 <e98090fc-ac39-93cf-c958-47c2faaea185@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id A998C266D61
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 13:14:46 +0100 (CET)
In-Reply-To: <e98090fc-ac39-93cf-c958-47c2faaea185@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20.11.2017 08:34, Clemens Ladisch wrote:
> Maciej S. Szmigiero wrote:
>> While reading alsa-lib sources I've spotted some strange code in
>> src/pcm/pcm_route.c:
>>        /* 3 bytes formats? */
>>        route->params.use_getput =
>>                (snd_pcm_format_physical_width(src_format) + 7) / 3 == 3 ||
>>                (snd_pcm_format_physical_width(dst_format) + 7) / 3 == 3;
> 
> "(x + n-1) / n" is "divide by n while rounding up".
> 
> "/ 3" should have been "/ 8".

Thanks for your explanation, I've submitted a patch for alsa-lib now.

> Regards,
> Clemens

Best regards,
Maciej
