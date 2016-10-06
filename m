From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: Audio on mx6q udoo
Date: Fri, 07 Oct 2016 00:46:42 +0200
Message-ID: <57F6D452.3020306@maciej.szmigiero.name>
References: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
 <57F6644F.3070500@maciej.szmigiero.name>
 <CAOMZO5DtJG6Otw8rfZQQymsoZJ4UhB2idgDCXgWN69OMyQc_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id D5C54266ABC
 for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2016 00:46:43 +0200 (CEST)
In-Reply-To: <CAOMZO5DtJG6Otw8rfZQQymsoZJ4UhB2idgDCXgWN69OMyQc_Ww@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 06.10.2016 21:01, Fabio Estevam wrote:
> Hi Maciej,
> 
(..)
> 
> I see the same issue with 4.7.6.
> 
> Are you able to get audio working with kernel 4.7.6?

On kernel 4.7.6:
1) Vanilla kernel - AC'97 codec misdetected, no sound.

2) After applying
"regmap: cache: Fix num_reg_defaults computation from reg_defaults_raw"
(commit b2c7f5d9c939a37c1ce7f86a642de70e3033ee9e) the codec is
detected properly and the sound is output properly.

However, since this commit is present in linux-next it can't
explain why you aren't getting any sound there.

> Thanks,
> 
> Fabio Estevam

Maciej
