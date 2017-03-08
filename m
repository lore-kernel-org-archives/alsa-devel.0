From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PLUGINS] Multichannel over I2S : extra cost of
 user space plugins
Date: Wed, 8 Mar 2017 15:34:53 +0100
Message-ID: <07e1b7d5-e36f-4e01-a453-b3d1bfc81049@ladisch.de>
References: <b4d4d4e3-1b94-4ff1-eabe-d3fe28b9b94c@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DD90F266B02
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 15:34:56 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id EE3575582158
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 15:34:55 +0100 (CET)
In-Reply-To: <b4d4d4e3-1b94-4ff1-eabe-d3fe28b9b94c@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Flax wrote:
> Recently I was advised to channel multichannel audio over stereo I2S

Why would you want to do that?  Don't you have the appropriate number of I=
=B2S lines?

> and unpack in user space with plugins.

Why?

> Right now, with a hacked machine driver, I get DMA unpacking to multichan=
nel for free.
>
> If I switch to user space ALSA plugin unpacking, as advised, can anyone a=
nswer the following questions please :
>
> If I want to handle all word sizes which are currently implemented S16 ->=
 S32, do I need to use different plugins to handle different word sizes ?

Plugins can query what the actual sample format is (and can constrain them =
to what they support).

> Regarding the actual channel unpacking, will it cost a lot more to do thi=
s in user space, rather then using the DMA silicon ?

Of course.


Regards,
Clemens
