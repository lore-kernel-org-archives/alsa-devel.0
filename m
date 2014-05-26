From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aplay: main:722: audio open error: No such file or
 directory
Date: Mon, 26 May 2014 10:30:33 +0200
Message-ID: <5382FBA9.4000402@ladisch.de>
References: <20140525091124.01578e75@kruskal.home.chead.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6945526087B
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 10:30:34 +0200 (CEST)
In-Reply-To: <20140525091124.01578e75@kruskal.home.chead.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christopher Head <alsa@chead.ca>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christopher Head wrote:
> asound # cat cards
>  0 [MID            ]: HDA-Intel - HDA Intel MID
>                       HDA Intel MID at 0xf4900000 irq 53
>  1 [NVidia         ]: HDA-Intel - HDA NVidia
>                       HDA NVidia at 0xf3080000 irq 17
>
> I can't play audio on non-default devices.
>
> Running aplay with -D hdmi does not work, failing with this message:
> aplay: main:722: audio open error: No such file or directory

The default card has no "hdmi" device.

Try -D hdmi:CARD=NVidia (or better plug:hdmi:CARD=NVidia to get
automatic sample format conversions).


Regards,
Clemens
