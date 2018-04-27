From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: tas6424: Add support for the
	mute pin
Date: Fri, 27 Apr 2018 15:15:05 -0500
Message-ID: <20180427201505.3wseaug6v2uak5mf@rob-hp-laptop>
References: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
 <1524837349-16350-3-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C542267412
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 22:15:07 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id p62-v6so2651671oie.10
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 13:15:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1524837349-16350-3-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, broonie@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 27, 2018 at 03:55:48PM +0200, Jean-Jacques Hiblot wrote:
> mute can be connected to GPIO. In that case we have to drive it to the
> correct value
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>  .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
>  sound/soc/codecs/tas6424.c                         | 37 +++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
