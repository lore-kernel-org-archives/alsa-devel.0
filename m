From: Matt Flax <flatmax@flatmax.org>
Subject: ASoC: of_parse_phandle techniques newbie question
Date: Thu, 14 Aug 2014 16:42:43 +1000
Message-ID: <53EC5A63.4070504@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A79E26565B
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 08:42:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there,

In implementing a codec/driver combination, I found that I have to 
re-write some of the snd_soc_dai_link with device tree related entries :
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080034.html

Can anyone explain to me why we have to do this, a little confused here ?
For example :

          driver_dai.codec_name = NULL;
          driver_dai.codec_of_node = of_parse_phandle(np, .....

Why can't the codec be found from the codec_name which matches the 
previously probed codec ?

thanks
Matt
