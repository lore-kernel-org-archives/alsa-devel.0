From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 5/5] tegraalc5632: add UCM config from
	Ubuntu
Date: Fri, 10 May 2013 10:22:59 -0600
Message-ID: <518D1EE3.10205@wwwdotorg.org>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
 <1368190270-29647-6-git-send-email-marcin@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id E4FE1261677
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 18:23:03 +0200 (CEST)
In-Reply-To: <1368190270-29647-6-git-send-email-marcin@juszkiewicz.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Cc: alsa-devel@alsa-project.org, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

On 05/10/2013 06:51 AM, Marcin Juszkiewicz wrote:
> Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
> ---
>  tegraalc5632/tegraalc5632.conf | 30 ++++++++++++++++++++++++++++++

I'm not sure that's the correct name for this file.

"alc5632" is the name of the audio CODEC, which could be used in a
variety of different boards, each of which might require a different UCM
configuration. Shouldn't the file be named based on the board name. At
least with upstream kernels, the device tree contains:

nvidia,model = "Compal PAZ00";

which should influence the name the kernel gives to the sound card, and
hence I think be the name the UCM config is looked up under?

> +		exec "echo Im setting defaults for tegra-alc5632"

I'm not sure if that's useful?

I also notice that this file doesn't define any use-cases/verbs/...
Presumably a Linux-based OS would expect a certain set of them to exist,
and they'd be implemented/named consistently across all UCM configs?
