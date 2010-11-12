From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.37 1/2] ASoC: Fix dapm_seq_compare()
 for multi-component
Date: Fri, 12 Nov 2010 19:10:45 +0000
Message-ID: <20101112191045.GH17283@rakim.wolfsonmicro.main>
References: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101112210637.0ec2d25c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7EADB10396B
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 20:10:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101112210637.0ec2d25c.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 09:06:37PM +0200, Jarkko Nikula wrote:

> This sounds feasible change. What I was thinking are there any
> benefit which one, the register or codec is compared first but I don't
> think there's any practical difference.

> A1, B1, A2, B2 (now)
> or
> A1, A2, B1, B2 (codec comparison before register)

If you've got two identical CODECs it will *probably* sound smoother to
alternate between the two rather than enabling one then the other -
there will be less time difference between any audible issues in each
path.  Probably a very small chance of that having an effect but it
seemed more likely to do something useful than any other scenario.
