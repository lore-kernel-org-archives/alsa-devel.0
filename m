From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SOC: UDA134x: Enable POWER_OFF_ON_STANDBY
	define.
Date: Tue, 3 May 2011 12:23:50 +0100
Message-ID: <20110503112350.GG1762@opensource.wolfsonmicro.com>
References: <1304415149-19725-1-git-send-email-marek.belisko@open-nandra.com>
	<20110503100042.GA1762@opensource.wolfsonmicro.com>
	<BANLkTimE_TEzManZb2McLnohqbc27hRZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC207103821
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 13:23:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimE_TEzManZb2McLnohqbc27hRZ=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 01:09:27PM +0200, Belisko Marek wrote:
> On Tue, May 3, 2011 at 12:00 PM, Mark Brown

> > If this is essential why is it optional in the first place?

> Not sure about background. Maybe whole define should be removed

That's exactly what I'm suggesting.

> This change was introduced in commit:f0fba2ad

*Always* include a plain text description of the commit for those of us
who haven't memorised the entire git history.  In this case I suspect
you need to do a bit more digging, that commit will just have done some
code motion here.
