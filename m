From: Liam Girdwood <lrg@ti.com>
Subject: Re: asoc: no valid backend routes for PCM
Date: Fri, 19 Aug 2011 17:20:39 +0100
Message-ID: <4E4E8D57.4000509@ti.com>
References: <4DF1076B.70308@ti.com>	<507506.95203.qm@web161717.mail.bf1.yahoo.com>
	<loom.20110819T095055-703@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C86ED246B8
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 18:20:45 +0200 (CEST)
In-Reply-To: <loom.20110819T095055-703@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sarika <sarikababy123@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 19/08/11 08:53, Sarika wrote:
> Hello,
>   I am not able to hear audio on my headset when it connect it to panda board.
> What mite be the issue?

This means you have no valid audio route from your pcm device to your headphone.

Please use the supplied UCM configuration files (with Ubuntu) to set the route or use alsamixer to do this manually.

http://www.omappedia.org/wiki/Audio_Drive_Arch

>   Also panda does not has DMIC does this make any difference ?
> 

No.

Liam

> Regards
> Sarika
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
