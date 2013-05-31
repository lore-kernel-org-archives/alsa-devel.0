From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: sgtl5000: Do not read registers
	prior to turning on the supplies
Date: Fri, 31 May 2013 19:20:01 +0200
Message-ID: <201305311920.02005.marex@denx.de>
References: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
 <201305311745.50326.marex@denx.de>
 <CAOMZO5CXMCQ8dN92BPfp5s7dz0Jfkm5MrK2duCjrt-s70gHJPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 49C58265534
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 19:20:05 +0200 (CEST)
In-Reply-To: <CAOMZO5CXMCQ8dN92BPfp5s7dz0Jfkm5MrK2duCjrt-s70gHJPA@mail.gmail.com>
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
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

> On Fri, May 31, 2013 at 12:45 PM, Marek Vasut <marex@denx.de> wrote:
> > Ah, that's _very_ likely. I think the chip will NAK I2C communication
> > without having clock supplied to it. I did look into this stuff with an
> > LA yesterday night and I saw the 2-byte write followed by I2C NAK.
> 
> Yes, I haven't had a chance to try enabling the saif clock earlier and
> I am currently out of office.

Send me a patch if you have time and I'll test it.

Best regards,
Marek Vasut
