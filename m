From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: adau17x1: Unused exported
 functions changed to internal
Date: Mon, 13 Aug 2018 12:45:39 +0200
Message-ID: <de63d19e-c3bf-5d25-7d91-a93cfb9cd47a@metafoo.de>
References: <20180813073359.3374-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DB3CA26780E
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2018 12:45:37 +0200 (CEST)
In-Reply-To: <20180813073359.3374-1-robertr@axis.com>
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
To: Robert Rosengren <robert.rosengren@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Rosengren <robertr@axis.com>
List-Id: alsa-devel@alsa-project.org

On 08/13/2018 09:33 AM, Robert Rosengren wrote:
> adau17x1_setup_firmware and adau17x1_has_dsp is only used internally, so
> making them static instead of exported.
> 
> Change-Id: I4882513ab457966b0371ac2c1024550ca6edbe0c
> Signed-off-by: Robert Rosengren <robertr@axis.com>

Thanks for cleaning this up.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
