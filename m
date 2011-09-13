From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Disable WM8996 CPVDD supply when
	not in use
Date: Tue, 13 Sep 2011 16:15:33 +0100
Message-ID: <20110913151533.GB23782@opensource.wolfsonmicro.com>
References: <1315846757-21084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1315846757-21084-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1315925600.5157.10.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F2A0103999
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 17:15:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315925600.5157.10.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2011 at 03:53:20PM +0100, Liam Girdwood wrote:
> On Mon, 2011-09-12 at 17:59 +0100, Mark Brown wrote:

> >  sound/soc/codecs/wm8996.c |   38 ++++++++++++++++++++++++++++++--------
> >  1 files changed, 30 insertions(+), 8 deletions(-)

> Acked-by: Liam Girdwood <lrg@ti.com>

Should I apply the regulator change to ASoC as well?  Obviously this
won't build without that.  Providing there aren't any merge issues this
could go via either tree (or I could just hang onto this until after the
merge window, it's not exactly urgent).
