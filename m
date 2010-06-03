From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 3 Jun 2010 12:20:24 +0100
Message-ID: <20100603112022.GA24589@sirena.org.uk>
References: <hu6v9i$v43$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 58FB3243C3
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 13:20:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <hu6v9i$v43$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 11:07:57AM +1000, Stuart Longland wrote:

Please do remember to CC maintainers on posts to mailing lists.  I've
had to remind you previously about dropping CCs (and see that you were
doing that again this morning)...

> My query though; the mixer on this CODEC provides gain settings, 
> helpfully scaled in dB, as signed integers.  For instance; the four line 
> level output drivers: Headphone left/right,and Line Out left/right, can 
> all be adjusted in gain from -6dB through to +29dB.

Are you looking for SOC_DOUBLE_R_SX_TLV and variants thereof by any
chance?  If you need variants you'd need to add them but that's
straightforward.
