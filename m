From: Timur Tabi <timur@freescale.com>
Subject: Re: Random inverted audio channels
Date: Fri, 15 Feb 2008 12:48:09 -0600
Message-ID: <47B5DE69.3030604@freescale.com>
References: <002201c86ff1$61de9e00$259bda00$@bouin@kerlink.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id AA90A243BD
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 19:48:16 +0100 (CET)
In-Reply-To: <002201c86ff1$61de9e00$259bda00$@bouin@kerlink.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexandre BOUIN wrote:

> We have an issue : when we play a right channel stereo track, sound is
> played on right channel, but sometimes on left.
> This issue could happen right after starting kernel, or later after 10-20
> sounds played.

I've had a similar problem.  In my case, the clock from the codec to the chip 
was unstable.  When I attached a 5pF capacitor to it, the clock stabilized and 
the problem went away.

Try using a probe to validate the clock signal.

-- 
Timur Tabi
Linux kernel developer at Freescale
