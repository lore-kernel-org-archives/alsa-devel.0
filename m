From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Problem and dirty Fix for hda-intel on ALC892
Date: Mon, 21 Mar 2011 22:44:15 +0100
Message-ID: <4D87C6AF.2090906@canonical.com>
References: <20110321113702.GA15206@atlantis.wh2.tu-dresden.de.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F22824475
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 22:44:14 +0100 (CET)
In-Reply-To: <20110321113702.GA15206@atlantis.wh2.tu-dresden.de.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, losinski@wh2.tu-dresden.de
List-Id: alsa-devel@alsa-project.org

On 2011-03-21 12:37, Jan Losinski wrote:
> Hello,
>
> Since last week I compiled 2.6.38 on my Desktop. After booting I noticed
> a regression at the sound stuff. The surround speaker where no longer
> controlled by the master volume control. I can control it separately,
> but not with the master control that controls the front, center and
> LFE volume.
>
> After some debugging I found some differencies at module-loading output
> in the kernel log and in the output from alsactl store command. The
> dmesg and the diff of the alsactl output can be found at the end of this
> message.
>
> After that I tried to understand the hda-codec code and debugged there
> with a lot of printks and reboots. It takes another couple of hours to
> find out that the index of the surround volume and switch was 0 at pre
> 2.6.38 and is now 1. So I wrote a dirty hack to fix this (please ignore
> the debugging printks):

Hmm, I made one or two patches in relation to this but they aimed at 
moving index 1 to index 0, not the other way around. Could you please 
give alsa-info (see wiki.ubuntu.com/Audio/AlsaInfo ) information, 
preferably with 2.6.38 (and without your workaround) installed?

Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
