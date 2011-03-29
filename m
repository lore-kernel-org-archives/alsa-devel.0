From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Blackfin: drop "-codec" from
	codec names
Date: Wed, 30 Mar 2011 07:19:26 +0900
Message-ID: <20110329221924.GH30482@opensource.wolfsonmicro.com>
References: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 203C910399B
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 00:19:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 28, 2011 at 01:45:08AM -0400, Mike Frysinger wrote:
> The recent multi-component patch incorrectly added "-codec" suffixes to
> parts which are not MFD.  Drop the suffix from the machine drivers too.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied all, thanks - note these should've also included the updates to
the machine drivers for bisection.
