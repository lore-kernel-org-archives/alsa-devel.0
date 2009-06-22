From: Ben Dooks <ben-alsa@fluff.org>
Subject: ASoC CODEC power management on reboot
Date: Mon, 22 Jun 2009 12:13:23 +0100
Message-ID: <20090622111323.GM14476@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id D302324368
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 13:13:23 +0200 (CEST)
Received: from ben by trinity.fluff.org with local (Exim 4.63)
	(envelope-from <ben@trinity.fluff.org>) id 1MIhSl-0004Zh-7T
	for alsa-devel@alsa-project.org; Mon, 22 Jun 2009 12:13:23 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've run into a problem where when the system reboots the audio
starts playing random data. I suspect that this is due to the CODEC
being left powered and when the during/after the reset process the
GPIO lines which form the I2S bus are left floating.

Should the ASoC (possibly DAPM) layer sort out powering down the CODEC
before reboot, or should it be down to the codec or the mapping driver
to do this?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
