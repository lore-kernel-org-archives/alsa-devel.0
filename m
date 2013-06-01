From: Marek Vasut <marex@denx.de>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 23:42:21 +0200
Message-ID: <201306012342.21418.marex@denx.de>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
 <20130601210534.GU16790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB62261AEA
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 23:42:27 +0200 (CEST)
In-Reply-To: <20130601210534.GU16790@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Dear Mark Brown,

> On Sat, Jun 01, 2013 at 04:20:50PM -0300, Fabio Estevam wrote:
> > What is the proper way to know this information?
> > 
> > Or how do I tell that each DAI is unidirectional?
> 
> If it's not got any playback or capture capabilities.

Each of the SAIFs has only one direction, the question Fabio probably wanted to 
ask is where he can fix the SAIF caps so they report only one direction instead 
of both.

Best regards,
Marek Vasut
