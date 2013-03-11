From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH] ALSA: ASoC: davinci-mcasp: clean ip
 davinci_hw_common_param()
Date: Mon, 11 Mar 2013 07:09:11 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED402CB@DBDE01.ent.ti.com>
References: <1362748778-11076-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 0272D2650DD
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 08:09:15 +0100 (CET)
In-Reply-To: <1362748778-11076-1-git-send-email-zonque@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 08, 2013 at 18:49:38, Daniel Mack wrote:
> As pointed of by Vaibhav, commit 2952b27e2 ("ASoC: davinci-mcasp:
> Add support for multichannel playback") duplicated the logic of
> counting the active serializers. That can be avoided by shifting
> the code around a bit.
> 
> Also, drop two unused defines introduced by the same commit.
> 

s/clean ip/clean up/ in the $subject.

Other than that, this looks fine to me.

Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
