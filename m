From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: adding an external dsp under soc-dsp framework
Date: Thu, 9 Aug 2012 11:57:00 +0100
Message-ID: <20120809105700.GM24328@opensource.wolfsonmicro.com>
References: <FC1850374E3CB245B9E97002380578E0022216D4@ILMAIL01.dspg.com>
 <20120806154822.GP16861@opensource.wolfsonmicro.com>
 <loom.20120806T203950-581@post.gmane.org>
 <20120807140902.GH29272@sirena.org.uk>
 <FC1850374E3CB245B9E97002380578E002221820@ILMAIL01.dspg.com>
 <20120808105919.GJ16861@opensource.wolfsonmicro.com>
 <FC1850374E3CB245B9E97002380578E00222188A@ILMAIL01.dspg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C9342652AB
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 12:36:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <FC1850374E3CB245B9E97002380578E00222188A@ILMAIL01.dspg.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ziv Haziz <Ziv.Haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 08, 2012 at 10:49:19PM +0300, Ziv Haziz wrote:

> Looking at the littlemill driver on kernel 3.4.7 the device name
> "Baseband" and his dai link doesn't contain platform device can be
> triggered without side effects?

Yes, this is the most common case for DAI links that don't involve a CPU
in modern smartphones.
