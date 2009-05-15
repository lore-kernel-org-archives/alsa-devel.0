From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] TXx9: Add ACLC support
Date: Fri, 15 May 2009 10:17:43 +0100
Message-ID: <20090515091741.GA4449@sirena.org.uk>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
	<20090515090118.GA7706@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 92930103959
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 11:17:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090515090118.GA7706@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 15, 2009 at 10:01:19AM +0100, Ralf Baechle wrote:
> On Thu, May 14, 2009 at 11:50:05PM +0900, Atsushi Nemoto wrote:

> > Add platform support for ACLC of TXx9 SoCs.

> Thanks, queued up for 2.6.31 / linux-next.

These will need revision after fixing my review comments for the audio
drivers - the way the platform devices are set up needs to be changed so
that the resources are associated with devices for the CPU rather than
the machine driver that says how a given board is connected up.
