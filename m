From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/1] intel8x0: Improve performance in
	virtual environment
Date: Thu, 20 Oct 2011 17:15:46 +0200
Message-ID: <4EA03B22.1020109@perex.cz>
References: <1319122970-49404-1-git-send-email-kozerkov@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1319122970-49404-1-git-send-email-kozerkov@parallels.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Konstantin Ozerkov <kozerkov@parallels.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, devices@parallels.com, "Denis V. Lunev" <den@parallels.com>
List-Id: alsa-devel@alsa-project.org

Date 20.10.2011 17:02, Konstantin Ozerkov wrote:
> This patch intended to improve performance in virtualized environments
> like Parallels Desktop or VirtualBox/QEMU (virtual ICH/AC97 audio).
> 
> I/O access is very time-expensive operation in virtual world: VCPU
> can be rescheduled and in the worst case we got more than 10ms delay on
> each I/O access.
> 
> In the original code normal loop exit rule
> (old_civ == current_civ && old_picb == current_picb) was never satisfied,
> because old_picb was never the same as current_picb due delay inspired by
> reading current_civ. As a result loop ended by timeout and we got 10x more
> I/O operations.
> 
> To prevent glitch on buffer swapping the rule (old_civ == current_civ) is
> enough.

I don't think so. This code was added because we got some strange
situations (values) with the real intel8x0 hardware. A better way might
be to identify the virtualisation (maybe using special PCI IDs) and skip
these extra checks in the driver for these devices.

NAK from me.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
