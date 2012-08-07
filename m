From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Plumbers: Please split audio topics into separate
	sessions
Date: Tue, 7 Aug 2012 12:15:19 +0100
Message-ID: <20120807111519.GY16861@opensource.wolfsonmicro.com>
References: <50201664.7000804@canonical.com> <s5hwr1bizuj.wl%tiwai@suse.de>
 <50202500.5060607@canonical.com>
 <20120806222417.GF26698@opensource.wolfsonmicro.com>
 <s5htxwfi6pb.wl%tiwai@suse.de> <5020B8AF.3090003@canonical.com>
 <s5hhasfi3b4.wl%tiwai@suse.de> <5020CD16.6020705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFB2926501A
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 12:51:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5020CD16.6020705@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 10:08:54AM +0200, David Henningsson wrote:

> When shutting down, both PulseAudio and alsactl saves volumes to
> restore them later. And then we also have suspend and hibernate to
> consider, and that cards can be plugged in at any time.

> This is mostly a problem statement. I don't have a good proposal for
> how to simplify it.

Isn't this a fairly simple Pulse/distro issue?  It seems like alsactl is
redundant for most distros now so they could just disable it by default
meaning we just have to worry about the DM/user Pulse handover.  For
that I guess if Pulse does something the distros would be happy to just
follow that?
