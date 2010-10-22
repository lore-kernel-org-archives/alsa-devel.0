From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Question regarding snd_pcm_control_ioctl
Date: Fri, 22 Oct 2010 10:56:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010221053520.29422@eeebox2.perex-int.cz>
References: <2A84145621092446B6659B8A0F28E26F46FE8E4B5B@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AFA122433A
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 10:56:36 +0200 (CEST)
In-Reply-To: <2A84145621092446B6659B8A0F28E26F46FE8E4B5B@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bensaid, Selma" <selma.bensaid@intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Oct 2010, Bensaid, Selma wrote:

> Hi,
>
> I have question concerning ALSA Core snd_pcm_control_ioctl function.
>
> I have noticed that the IOCTL fails if it's called for a device with 
> substream_count = 0, since I'm implementing a PCM device that supports 
> Record and does not support Playback, the IOCTL fails when called for 
> the Playback stream. I would propose, in such case, to return that the 
> stream has 0 playback substreams instead of failing.

You mean probably that the SNDRV_CTL_IOCTL_PCM_INFO ioctl returns -ENOENT 
when an invalid direction is accessed. It looks correct to me. If 
a direction does not exist, it makes no sense to gather info for it. And 
-ENOENT response clearly shows that this direction is not available, so 
the user space tools can distict if it's an unexpected error or this one.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
