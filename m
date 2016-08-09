From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/39] ALSA: seq: obsolete address mode in
 compatibility layer
Date: Tue, 9 Aug 2016 21:32:30 +0900
Message-ID: <f51ae36a-a4f8-350e-a900-7b4f7a9867b4@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-7-git-send-email-o-takashi@sakamocchi.jp>
 <s5hvazbohxj.wl-tiwai@suse.de>
 <da681afe-e92e-158a-f212-cd5e4d3a18df@sakamocchi.jp>
 <s5hfuqfnw5t.wl-tiwai@suse.de>
 <cae4f730-05cb-c805-371c-29dbcfa7bbe5@sakamocchi.jp>
 <s5hmvkm2l5f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0C85D266A13
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:32:32 +0200 (CEST)
In-Reply-To: <s5hmvkm2l5f.wl-tiwai@suse.de>
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

On Aug 9 2016 21:15, Takashi Iwai wrote:
> But, why do you need to change these changes at all?  What you
> basically need is to change the call inside seq_call_port_info_ioctl()
> like:
> 
> -	err = snd_seq_do_ioctl(client, cmd, data);
> +	err = snd_seq_kernel_client_ctl(client->number, cmd, data);
> 
> Then the rest can remain intact.  Referencing client->number in each
> caller side just results in inefficient codes, obviously.

In seq_call_port_info_ioctl(), no members except for the 'number' are
used. So no need to get a pointer to the client data as an argument.

This change makes it simpler for readers to follow code of the function.
They have no need to think about the whole data, it's OK just to focus
on the numerical ID for client.


Regards

Takashi Sakamoto
