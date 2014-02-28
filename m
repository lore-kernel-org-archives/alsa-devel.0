From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 2/3] route: Select slave chmap based on
 ttable information
Date: Fri, 28 Feb 2014 14:52:46 +0100
Message-ID: <531094AE.1010408@canonical.com>
References: <1393574227-25732-1-git-send-email-david.henningsson@canonical.com>	<1393574227-25732-3-git-send-email-david.henningsson@canonical.com>
 <CAN8cciY6OXQ2m0bU7rRfUVFGGxeeSTqZfgRraEEmVm8uRKUQEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 475D026595C
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 14:52:48 +0100 (CET)
In-Reply-To: <CAN8cciY6OXQ2m0bU7rRfUVFGGxeeSTqZfgRraEEmVm8uRKUQEA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/28/2014 02:49 PM, Raymond Yau wrote:
> 
> 
> 
> 2014-02-28 15:57 GMT+08:00 David Henningsson
> <david.henningsson@canonical.com <mailto:david.henningsson@canonical.com>>:
> 
>     It means we need to initialize this order:
> 
>      1) Read the ttable to figure out which channels are present
>      2) Open slave pcm and find a matching chmap
>      3) Determine size of ttable (this can now depend on the chmap)
>      4) Read ttable coefficients
>      5) At prepare time, select the matching chmap
> 
> 
> Do this patch assume the slave.pcm of the route plugin must have a
> channel map ?

No. In that case, it will fall back to ALSA's standard channel map ( FL
-> 0, FR -> 1, etc).

> are there any side effect when some of sound cards using route but does
> not have channel map ?

If there is no channel map, things should remain unchanged.

> 
> 
> 
> e.g. ice1712,
> 
> 	playback.pcm {
> 		type hooks
> 		slave.pcm {
> 			type route
> 			ttable.0.8 1
> 			ttable.1.9 1
> 			slave.pcm {
> 				type hw
> 				card $CARD
> 			}
> 			slave.format S32_LE
> 			slave.channels 10
> 		}
> 
> 
> rme9652, ....
> 
> slave.pcm {
> 		type route
> 		slave {
> 			pcm {
> 				type hw
> 				card $CARD
> 			}
> 			channels 26
> 		}
> 		ttable.0.24 1
> 		ttable.1.25 1
> 
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
