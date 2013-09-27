From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pcm_rate API  question
Date: Fri, 27 Sep 2013 14:38:23 +0200
Message-ID: <52457C3F.5090003@ladisch.de>
References: <1380283173.50500.YahooMailNeo@web171404.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 911D926508F
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 14:38:25 +0200 (CEST)
In-Reply-To: <1380283173.50500.YahooMailNeo@web171404.mail.ir2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Sykes <aquegg@yahoo.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rob Sykes wrote:
>         void (*convert_s16)(void *obj, int16_t *dst, unsigned int dst_frames,
>                             const int16_t *src, unsigned int src_frames);
>
> is the plugin obliged always to consume src_frames and generate dst_frames samples?

Yes.  src_frames and dst_frames are the period sizes of the respective
devices; their values will never change, and they define the actual
conversion ratio.


Regards,
Clemens
