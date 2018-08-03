From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: bug report. Envy24 based card (terratec ews88d)
 won't slave to external clock via s/pdif.
Date: Fri, 3 Aug 2018 08:29:58 +0200
Message-ID: <dce55863-8fb7-3567-be95-b23c96ced513@ivitera.com>
References: <CAFO8paF9fKtf1RNNK9iaUheto7Orx1VyBsVqA_dWoM3qbpoeZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 383EA2677DA
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 08:30:02 +0200 (CEST)
In-Reply-To: <CAFO8paF9fKtf1RNNK9iaUheto7Orx1VyBsVqA_dWoM3qbpoeZQ@mail.gmail.com>
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
To: Tobias Eklund <tobias.h.e.eklund@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 2.8.2018 v 22:03 Tobias Eklund napsal(a):
> Hi,
> 
> when trying to clock my terratec ews88d from an apogee rosetta AD it just
> won't. The s/pdif input works but the card won't lock to the s/pdif clock
> but rather stay at whatever setting it was at before i change to s/pdif in
> envy24control or mudita24.
> 

Hi,

I do not see any implementation of incoming rate monitoring in the 
EWS88D source code 
https://github.com/torvalds/linux/blob/c0da4fa0d1a54495d6055c009ac46b76d1da2c86/sound/pci/ice1712/ews.c 
I do not think the driver covers these features.

If you want to add the functionality, look e.g. at how Juli  does the 
incoming rate monitoring  (juli.c, scheduled task in ak4114 
https://elixir.bootlin.com/linux/latest/source/sound/i2c/other/ak4114.c#L617 
). Unfortunately the code for checking is rather complex.

With regards,

Pavel.
