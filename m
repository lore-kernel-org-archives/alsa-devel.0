From: Sebastian <ehlke@bewatec.de>
Subject: Re: OMAP4 McBSP AC97 link
Date: Thu, 27 Sep 2012 08:58:09 +0000 (UTC)
Message-ID: <loom.20120927T103143-101@post.gmane.org>
References: <loom.20120927T093059-361@post.gmane.org>
 <50640768.7040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 04837261600
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 10:58:26 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TH9vM-0007jk-Mc
 for alsa-devel@alsa-project.org; Thu, 27 Sep 2012 10:58:24 +0200
Received: from p5099c495.dip0.t-ipconnect.de ([80.153.196.149])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 10:58:24 +0200
Received: from ehlke by p5099c495.dip0.t-ipconnect.de with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 10:58:24 +0200
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

Daniel Mack <zonque <at> gmail.com> writes:

> 
> On 27.09.2012 09:44, Sebastian wrote:
> > Hi All,
> > 
> > i have to support a 2nd Audio Codec with AC97 Interface on McBSP Port2.
> > Processor: OMAP4460
> > 
> > If any one have any idea on how to go about this. 
> > Please let me know.
> 
> If you need to support a second codec on a dedicated bus, all you have
> to do is set up a new snd_soc_dai_link. Read the documentation in
> Documentation/sound/alsa/soc/ and see many of the good example in the
> mainline kernel tree.
> 
> If your goal is to support a second codec in parallel to another one,
> dynamix PCM (DPCM) is what you want to have a look at. It's there in the
> kernel since 3.5, but AFAIK there's currently no user of it that can
> serve as an example.
> 
> HTH,
> Daniel
> 
> 

Hi Daniel,

my Board has 1x TWL6040(PDM/I2C) and 1x WM9715(AC97/MCBSP) so to independent
interfaces. I would like to use both Codecs simultaneously. So it might be
sufficient to create a new new snd_soc_dai_link?

thx
Sebastian
