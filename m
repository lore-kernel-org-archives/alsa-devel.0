From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 19:37:11 +0100
Message-ID: <20080801183711.GG11735@sirena.org.uk>
References: <200808012023.38353.marek.vasut@gmail.com>
	<808063.227.qm@web50101.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 974B92433F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 20:37:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <808063.227.qm@web50101.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Mahajan <nitinm76@yahoo.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 11:26:36AM -0700, Nitin Mahajan wrote:

> > yea, and you should see alsa warning about it in kernel log
> > as well.

> Do you mean in dmesg?
> Unfortunately I don't have hardware with me now to test. I shall do it tommorow morning.

Yes, but you won't see that log message with the older kernel you are
using unless you have also backported ASoC from the current kernel (but
if you've done that I'd have expected you'd have backported a current
version with the patch in question already applied).
