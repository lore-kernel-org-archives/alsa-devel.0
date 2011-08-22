From: Liam Girdwood <lrg@ti.com>
Subject: Re: asoc: no valid backend routes for PCM
Date: Mon, 22 Aug 2011 11:54:15 +0100
Message-ID: <4E523557.8060101@ti.com>
References: <4DF1076B.70308@ti.com>	<507506.95203.qm@web161717.mail.bf1.yahoo.com>	<loom.20110819T095055-703@post.gmane.org>	<4E4E8D57.4000509@ti.com>
	<CAHgabbYxe-mzwhxiivj5Xmqdq3FQuZ3ZFhgU4wy_bCosm2BhwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 90F1524555
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:54:20 +0200 (CEST)
In-Reply-To: <CAHgabbYxe-mzwhxiivj5Xmqdq3FQuZ3ZFhgU4wy_bCosm2BhwA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sarika baby <sarikababy123@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Please don't drop the list from replies.

On 22/08/11 06:38, sarika baby wrote:
> Hello,
> Thanks for your information, but can you tell that if i have to add the audio route should i have to do it at kernel drivers level or else at ALSA (mydroid level) ?
> 

The routes are all configured in userspace with either UCM, alsamixer, amixer or by calling the alsa-lib C API.

Liam

> Thanks and Regards
> Soujanya
> 
> On Fri, Aug 19, 2011 at 9:50 PM, Liam Girdwood <lrg@ti.com <mailto:lrg@ti.com>> wrote:
> 
>     On 19/08/11 08:53, Sarika wrote:
>     > Hello,
>     >   I am not able to hear audio on my headset when it connect it to panda board.
>     > What mite be the issue?
> 
>     This means you have no valid audio route from your pcm device to your headphone.
> 
>     Please use the supplied UCM configuration files (with Ubuntu) to set the route or use alsamixer to do this manually.
> 
>     http://www.omappedia.org/wiki/Audio_Drive_Arch
> 
>     >   Also panda does not has DMIC does this make any difference ?
>     >
> 
>     No.
> 
>     Liam
> 
>     > Regards
>     > Sarika
>     >
>     >
>     > _______________________________________________
>     > Alsa-devel mailing list
>     > Alsa-devel@alsa-project.org <mailto:Alsa-devel@alsa-project.org>
>     > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
> 
> 
> -- 
> SarikA
> 
