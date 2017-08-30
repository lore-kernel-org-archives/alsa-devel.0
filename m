From: Lambdadroid <lambdadroid@gmail.com>
Subject: Re: Unable to play MP3 using TinyCompress and
	bytcr-rt5640
Date: Wed, 30 Aug 2017 21:31:40 +0200
Message-ID: <CAOmiHeJRLDix5A_2--HEihKic3jifLxSeSi-kyr=NSCNFCxhBg@mail.gmail.com>
References: <CAOmiHe+qmw34f_-yTqj6zy96bLXyGntd4qLAiQ8Aimmh5+rH=Q@mail.gmail.com>
 <8f328187-c23c-618c-3d62-73e6643a3e60@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DD82665D5
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 21:31:41 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id d15so5956465qta.5
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 12:31:41 -0700 (PDT)
In-Reply-To: <8f328187-c23c-618c-3d62-73e6643a3e60@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 30, 2017 at 9:20 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> The firmware available upstream does not contain MP3/AAC or proprietary
> libraries due to redistribution rights. Some of patents may start to expire
> soon but in general we steer clear of such components for freely available
> binary firmware. Not my choice btw, this is a minefield that's all too
> common for all open-source projects.
>
> The benefits of mp3 offload on Baytrail are quite limited anyway due to
> internal SoC design choices, I wouldn't recommend you pursue this work if
> power optimization was the goal. Offload was mostly used for Medfield,
> Clovertrail, Merrifield and Anniedale platforms.
>

Alright, thanks a lot for letting me know! I was mostly just curious
if it works when I saw that it's (theoretically) supported on
bytcr-rt5640. Is there any way to check if the firmware supports it
from the kernel side? It would be helpful if either the compressed
ALSA device wasn't even available or if there was at least a readable
error when attempting to use it. It's quite confusing when it appears
to be supported but it isn't working and other people might run into
this issue as well.
