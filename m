From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: Re: [PATCH alsa-lib 1/2] pcm_share: Fix compiler
 warnings -Wunused-result
Date: Thu, 15 Nov 2018 18:30:18 +0100
Message-ID: <e9666664-14a6-1bb0-e9b6-0cb6ad45f6af@birdec.tech>
References: <20181115071957.22753-1-kmarinushkin@birdec.tech>
 <s5h8t1ua999.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A0AD2679C0
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 18:28:20 +0100 (CET)
In-Reply-To: <s5h8t1ua999.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

On 11/15/18 12:08, Takashi Iwai wrote:
> On Thu, 15 Nov 2018 08:19:56 +0100,
> Kirill Marinushkin wrote:
>>
>> Before this commit, compilation of `pcm_share` causes warnings "ignoring
>> return value" for several `read` and `write` operations:
>>
>> ~~~~
>> pcm_share.c: In function '_snd_pcm_share_missing':
>> pcm_share.c:293:5: warning: ignoring return value of 'read', declared with
>> attribute warn_unused_result [-Wunused-result]
>>      read(share->slave_socket, buf, 1);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> <...>
>> ~~~~
>>

> Which compiler version?  I'm using gcc 8.2.1, and couldn't get any
> warnings like the above.
> 
> 
> thanks,
> 
> Takashi
> 

My gcc version is 6.4.0

Best Regards,
Kirill
