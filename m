From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l51: Don't log if we fail to
 allocate memory
Date: Tue, 11 Feb 2014 19:47:46 +0000
Message-ID: <C991C795-1FAB-48ED-8E4D-D58279C89868@cirrus.com>
References: <1392146808-19269-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id B714126084D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 20:47:57 +0100 (CET)
In-Reply-To: <1392146808-19269-1-git-send-email-broonie@kernel.org>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org



> On Feb 11, 2014, at 13:27, "Mark Brown" <broonie@kernel.org> wrote:
> 
> From: Mark Brown <broonie@linaro.org>
> 
> The VM subsystem already logs quite loudly if we run out of memory so
> don't bother here.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
> sound/soc/codecs/cs42l51.c
Acked-by: Brian Austin <brian.austin@cirrus.com>
