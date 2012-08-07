From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: adding an external dsp under soc-dsp framework
Date: Tue, 7 Aug 2012 15:09:02 +0100
Message-ID: <20120807140902.GH29272@sirena.org.uk>
References: <FC1850374E3CB245B9E97002380578E0022216D4@ILMAIL01.dspg.com>
 <20120806154822.GP16861@opensource.wolfsonmicro.com>
 <loom.20120806T203950-581@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 80EE6265CD6
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 17:54:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20120806T203950-581@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ziv haziz <ziv.haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 06:43:02PM +0000, ziv haziz wrote:
> Mark Brown <broonie <at> opensource.wolfsonmicro.com> writes:
> > On Mon, Aug 06, 2012 at 06:11:33PM +0300, Ziv Haziz wrote:

Don't drop people from CCs.

> > > ok thanks. This means that I need to introduce two codecs and make a dai
> > > link between them?
> > >  It doesn't really fits the dai structure - how do you suggest to do it?

> > No, if they're part of the same physical chip then they should be
> > handled internally to the device.

> it is a seperated chipset, only digital interfaces which should come between the 
> cpu and the codec.

In that case what you're saying above with a DAI link is exactly what
you're supposed to do, I don't see any structural problem here?
