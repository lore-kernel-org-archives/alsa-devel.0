From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [PATCH] Add SSID for Dell XPS400
	to	stac922x_cfg_tbl[]
Date: Fri, 08 Jun 2007 00:46:01 -0700
Message-ID: <1181288761.20297.95.camel@razman.gruemaster.com>
References: <1181286326.16999.4.camel@Box.ncat.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E5B722467A
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 09:46:03 +0200 (CEST)
In-Reply-To: <1181286326.16999.4.camel@Box.ncat.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: crimsun@ubuntu.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You might want to try either the 3stack model or the 5stack model
instead of the ref model.  The ref model was created primarily for
developers to hook up a Sigmatel test board to an Intel 945 motherboard,
and doesn't match the normal board configurations.


On Fri, 2007-06-08 at 03:05 -0400, Daniel T. Chen wrote:

> Hi,
> 
> Attached please find an hg changeset against current alsa-kernel tip
> adding a quirk entry for a Dell XPS400.
> 
> Thanks,
> Daniel Chen
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
