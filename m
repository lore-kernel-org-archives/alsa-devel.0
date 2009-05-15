From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] TXx9: Add ACLC support
Date: Fri, 15 May 2009 11:09:51 +0100
Message-ID: <20090515100951.GB2821@linux-mips.org>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
	<20090515090118.GA7706@linux-mips.org>
	<20090515091741.GA4449@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id AE8012433A
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 12:10:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090515091741.GA4449@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 15, 2009 at 10:17:43AM +0100, Mark Brown wrote:

> On Fri, May 15, 2009 at 10:01:19AM +0100, Ralf Baechle wrote:
> > On Thu, May 14, 2009 at 11:50:05PM +0900, Atsushi Nemoto wrote:
> 
> > > Add platform support for ACLC of TXx9 SoCs.
> 
> > Thanks, queued up for 2.6.31 / linux-next.
> 
> These will need revision after fixing my review comments for the audio
> drivers - the way the platform devices are set up needs to be changed so
> that the resources are associated with devices for the CPU rather than
> the machine driver that says how a given board is connected up.

Ok; I re-queued the patch into my -mm tree until we declare it ripe.

  Ralf
