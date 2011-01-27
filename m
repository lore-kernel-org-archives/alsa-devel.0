From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - [hdspmixer] 1/1] hdspmixer: Don't use
 channelmap from hdspm.h
Date: Thu, 27 Jan 2011 11:47:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101271147230.6272@eeebox2.perex-int.cz>
References: <1296124907-7995-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1296124907-7995-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jan 2011, Adrian Knoth wrote:

> The channel mapping has been moved to hdspm.c, so it's no longer
> available to userspace tools. For now, let's simply copy (duplicate) the
> data and wait for a way to query this information from the driver.
>
> Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

Applied. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
