From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Do not read registers
 prior to turning on the supplies
Date: Fri, 31 May 2013 12:52:05 -0300
Message-ID: <CAOMZO5CXMCQ8dN92BPfp5s7dz0Jfkm5MrK2duCjrt-s70gHJPA@mail.gmail.com>
References: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
 <201305311732.24103.marex@denx.de>
 <CAOMZO5Ab1gfTr4Fi3jXAXtR2LEdBcT6nyNRgm3djpBeRnaz-qg@mail.gmail.com>
 <201305311745.50326.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 17AF826173C
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 17:52:05 +0200 (CEST)
Received: by mail-vc0-f173.google.com with SMTP id ht10so1172303vcb.18
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 08:52:05 -0700 (PDT)
In-Reply-To: <201305311745.50326.marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 31, 2013 at 12:45 PM, Marek Vasut <marex@denx.de> wrote:

> Ah, that's _very_ likely. I think the chip will NAK I2C communication without
> having clock supplied to it. I did look into this stuff with an LA yesterday
> night and I saw the 2-byte write followed by I2C NAK.

Yes, I haven't had a chance to try enabling the saif clock earlier and
I am currently out of office.

Thanks,

Fabio Estevam
