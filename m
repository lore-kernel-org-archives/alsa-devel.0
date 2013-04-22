From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [RFC] ASoC: Current state of Dynamic PCM API
Date: Mon, 22 Apr 2013 07:57:35 -0700
Message-ID: <51754FDF.5050401@gmail.com>
References: <CABJ1b_QQS7amB3jTMvKGsJAC-QuPj4DmPNg-1waAqgC-Y8Ry7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id E42B2260202
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 16:57:45 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id bj1so1747837pad.20
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 07:57:44 -0700 (PDT)
In-Reply-To: <CABJ1b_QQS7amB3jTMvKGsJAC-QuPj4DmPNg-1waAqgC-Y8Ry7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 04/18/2013 05:07 AM, Sebastian Hesselbarth wrote:
> Can any of you point me to patches, repositories, or documentation
> about DPCM where I can start with?


One that I know of is here:

    http://git.omapzoom.org/?p=kernel/omap.git;a=summary
    branch: p-android-omap-3.4, p-linux-omap-3.4
    machine driver: sound/soc/omap/omap-abe-twl6040.c (OMAP4, OMAP5)

There's also stuff on the 3.0 and 3.1 branches... but 3.4 more closely 
resembles the current API.

-gabriel
