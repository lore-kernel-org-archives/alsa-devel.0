From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compiler warning - overriding codec compress type
Date: Mon, 18 Apr 2011 11:25:43 +0200
Message-ID: <4DAC0397.6040803@ladisch.de>
References: <4DABDC2E.9080103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A5E8B1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 11:24:02 +0200 (CEST)
In-Reply-To: <4DABDC2E.9080103@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Patrick Lai wrote:
> I got a compiler warning soc-core.c: In function
> 'snd_soc_instantiate_cards' warning: 'compress_type' may be used
> uninitialized in this function. In reality, compress_type is defined as
> local variable in snd_soc_instantiate_card().

Please note that this warning is merely a tool to find errors in the
code; the word "may" indicates that the compilter isn't sure about this.

> I think the fix should look like the following:
> 
> list_for_each_entry(codec, &codec_list, list) {
>                  if (codec->cache_init)
>                          continue;
> +               compress_type = 0;
>                  /* check to see if we need to override the compress_type */
>                  for (i = 0; i < card->num_configs; ++i) {
>                          codec_conf = &card->codec_conf[i];

When the for loop does not find an override, the following if() will
jump out of the outer list_for_each_entry loop before the compress_type
could be used, so it is not actually necessary to initialize this
variable; a better way would be to use uninitialized_var.

> My kernel version is 2.6.38. Has the warning being addressed in 2.6.39 
> or 2.6.40 patches?

... and an even better way is to simplify the logic:
http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=3110b8b0206cba978d95895723a3d901fb0f738d


Regards,
Clemens
