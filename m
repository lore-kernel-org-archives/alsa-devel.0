From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/9] ARM: DaVinci: ASoC: Adds Audio	support
	for TI DM646X
Date: Mon, 16 Mar 2009 15:38:56 +0000
Message-ID: <20090316153855.GI16539@sirena.org.uk>
References: <1237204854-29989-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 57AFB24133
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 16:38:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237204854-29989-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 16, 2009 at 08:00:54AM -0400, Naresh Medisetty wrote:
> Adds Audio support for TI DM646X EVM platform

> Signed-off-by: Naresh Medisetty <naresh@ti.com>

I'm broadly OK with anything I haven't specifically commented on here.
However, the ASoC bits of the series need to be updated to reflect the
current ASoC APIs.  Some additional documentation for your changes to
the EVM would be very helpful.

It would also be very much better if you could restructure the series to
reflect the changes you're making.  You're actually doing three things:

 - Add support for a dummy codec.
 - Add support for the McASP port on the DaVinci.
 - Update the DaVinci EVM driver to use these two things on relevant
   EVMs.

and the series should be structured to reflect this.  The codec and EVM
support should each go in a single patch by themselves.  The McASP
support is big enough to be broken down but it does need to come before
the EVM support that uses it.
