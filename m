From: ziv haziz <ziv.haziz@dspg.com>
Subject: Re: adding an external dsp under soc-dsp framework
Date: Mon, 6 Aug 2012 18:43:02 +0000 (UTC)
Message-ID: <loom.20120806T203950-581@post.gmane.org>
References: <FC1850374E3CB245B9E97002380578E0022216D4@ILMAIL01.dspg.com>
 <20120806154822.GP16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id DD400265DC7
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 20:13:35 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SySGs-00039b-26
 for alsa-devel@alsa-project.org; Mon, 06 Aug 2012 20:43:18 +0200
Received: from bzq-79-180-216-7.red.bezeqint.net ([79.180.216.7])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 20:43:18 +0200
Received: from ziv.haziz by bzq-79-180-216-7.red.bezeqint.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 20:43:18 +0200
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

Mark Brown <broonie <at> opensource.wolfsonmicro.com> writes:

> 
> On Mon, Aug 06, 2012 at 06:11:33PM +0300, Ziv Haziz wrote:
> 
> > ok thanks. This means that I need to introduce two codecs and make a dai
> > link between them?
> >  It doesn't really fits the dai structure - how do you suggest to do it?
> 
> No, if they're part of the same physical chip then they should be
> handled internally to the device.
it is a seperated chipset, only digital interfaces which should come between the 
cpu and the codec.
