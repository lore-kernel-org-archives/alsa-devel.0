From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: generic: add simple card with
	devicetree support
Date: Sat, 20 Jul 2013 21:14:50 -0600
Message-ID: <51EB522A.8060203@wwwdotorg.org>
References: <20130720192554.79b7061b@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9B12610A1
 for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2013 05:14:52 +0200 (CEST)
In-Reply-To: <20130720192554.79b7061b@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 07/20/2013 11:25 AM, Jean-Francois Moine wrote:
> This generic simple card driver uses DT values to instanciate an audio
> system in which the real work is done by the subdrivers (audio
> controller, audio codec and pcm/dma controller).

New DT bindings should be sent to devicetree@vger.kernel.org for review.
Note that's a branch new list (it moved from a different server), so it
might be best to wait a few days for people to subscribe before sending
mail to it.
