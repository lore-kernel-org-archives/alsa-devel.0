From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Fix front mic on Dell Precision
 M6500
Date: Mon, 23 Aug 2010 14:07:30 -0500
Message-ID: <1282590450.2600.9.camel@laptop>
References: <4C72C5EF.6090600@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DA4B2414B
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 21:07:34 +0200 (CEST)
In-Reply-To: <4C72C5EF.6090600@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

For laptops you would want to take preference of the docking jack over
the interal mic if you are in a docking station.

So if you do plug into a docking station and you have a microphone in
the docking station, a user would want to use that over the internal
microphone. You wouldn't want the laptop internal mic preferred over the
docking station microphone.

				Thanks,
					Jerone

On Mon, 2010-08-23 at 21:03 +0200, David Henningsson wrote:
> The BIOS of Dell Precision M6500 lists both 0x0e and 0x11 as
> front mics, and the driver only supports one front mic. This
> commit adds a quirk for preferring node 0x11 (internal mic) to
> node 0x0e (possibly docking station mic).
> 
> Alsa-info reference:
> http://launchpadlibrarian.net/54232083/alsa-info.txt.xyFVpIysHt
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
