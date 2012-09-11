From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need help with failed driver initialization
Date: Tue, 11 Sep 2012 04:43:56 +0100
Message-ID: <20120911034356.GA22446@sirena.org.uk>
References: <504E0F91.4040907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D77A264F25
 for <Alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 05:43:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <504E0F91.4040907@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 11:04:33AM -0500, Timur Tabi wrote:
> Every 6-12 months it seems, my audio drivers break because of some
> update to the ASoC.  It's that time again.

It would really help if your drivers, especially the probing stuff, were
more mainstream.  The fact that your device registration is entirely in
code rather than using structures makes things especially fragile as 
it's not even particularly visible what the code is doing.  If you could
move over to more standard code that'd help a lot.
