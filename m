From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: dapm: Allow regulators to bypass as well as
 disable when idle
Date: Fri, 28 Sep 2012 11:42:34 +0100
Message-ID: <20120928104233.GA30869@opensource.wolfsonmicro.com>
References: <20120927195758.GA10652@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 028CC2615CE
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 12:42:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120927195758.GA10652@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 27, 2012 at 10:57:58PM +0300, Dan Carpenter wrote:

> Right now ->invert is a single bit bitfield.  We mostly test
> "if (w->invert) {...".  Are we planning to add some more bits in there?

There aren't any plans at present, but it's possible we might add some.
When we do the definition of invert will have to change as you point
out.
