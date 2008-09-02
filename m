From: Jean Delvare <khali@linux-fr.org>
Subject: Re: |PATCH] ASoC: Convert wm8510 to a new-style i2c
 driver
Date: Tue, 2 Sep 2008 16:39:59 +0200
Message-ID: <20080902163959.36ea242a@hyperion.delvare>
References: <20080901112331.594bb663@hyperion.delvare>
	<20080902130720.GD25176@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 302CB246D4
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 16:40:07 +0200 (CEST)
In-Reply-To: <20080902130720.GD25176@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <gwossum@acm.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, 2 Sep 2008 14:07:20 +0100, Mark Brown wrote:
> On Mon, Sep 01, 2008 at 11:23:31AM +0200, Jean Delvare wrote:
> > Convert the wm8510 codec driver to the new (standard) device
> > driver binding model.
> 
> Hrm.  This doesn't actually apply for me, even if I apply directly
> against 2.6.27-rc5 - I get rejects in wm8510.c in the main conversion
> hunk.  Any chance you could regenerated it against Takashi's tree?

Sorry about that, apparently I messed up and corrupted the original
source file before generating the patch. I'll start again from the
correct file and will post an updated patch. I had a minor update to
make anyway so I wanted to resend it.

-- 
Jean Delvare
