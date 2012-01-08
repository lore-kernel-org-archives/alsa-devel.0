From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix possible hang and
	overflow in parse_uac2_sample_rate_range()
Date: Sun, 08 Jan 2012 08:55:11 -0500
Message-ID: <4F09A03F.6020300@gmail.com>
References: <1325698749-5353-1-git-send-email-xi.wang@gmail.com>
	<s5hehvamuh4.wl%tiwai@suse.de>
	<780588F2-6183-44B3-8EB8-CB82FB3DD8A7@gmail.com>
	<s5h39bqmiuo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E728024394
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 14:55:16 +0100 (CET)
Received: by iaae16 with SMTP id e16so5323099iaa.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2012 05:55:15 -0800 (PST)
In-Reply-To: <s5h39bqmiuo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Wolfgang Breyha <wbreyha@gmx.net>
List-Id: alsa-devel@alsa-project.org

On 1/8/12 8:20 AM, Takashi Iwai wrote:
> It's way too higher than any realistic situation ;)
> I guess 1000 or such should suffice.

Let's limit it to 1024 then. ;-)

I will do a v2.  Thanks.

- xi
