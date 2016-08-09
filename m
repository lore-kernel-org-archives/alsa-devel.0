From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/39] ALSA: seq: obsolete address mode in
 compatibility layer
Date: Tue, 9 Aug 2016 21:04:37 +0900
Message-ID: <cae4f730-05cb-c805-371c-29dbcfa7bbe5@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-7-git-send-email-o-takashi@sakamocchi.jp>
 <s5hvazbohxj.wl-tiwai@suse.de>
 <da681afe-e92e-158a-f212-cd5e4d3a18df@sakamocchi.jp>
 <s5hfuqfnw5t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id B6469267A62
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:04:42 +0200 (CEST)
In-Reply-To: <s5hfuqfnw5t.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Aug 8 2016 23:59, Takashi Iwai wrote:
> On Mon, 08 Aug 2016 14:19:50 +0200,
> Takashi Sakamoto wrote:
>>
>> On Aug 8 2016 16:09, Takashi Iwai wrote:
>>> It's better to pass a snd_seq_client pointer to this function and
>>> evaluate client->port in the function instead of referencing to
>>> client->port from each caller.
>>
>> ?
>>
>> I don't understand to what you addressed. Neither snd_seq_do_ioctl()
>> and snd_seq_kernel_client_ctl() have differences about port
>> referencing.
> 
> Put in this way: why did you change seq_call_port_ioctl() to take an
> clientid integer instead of client pointer?  Due to this change, each
> caller has to deduce the client number by referencing client->number.
> Which merit does it give at all?

Just to call snd_seq_kernel_client_ctl(). The callers are in 32/64 bit
compatibility code and the function is not exported.

I don't realize what you concern yet.


Regards

Takashi Sakamoto
