From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Altec Lansing FX5051 mixer
Date: Mon, 27 Aug 2007 18:18:55 +0200
Message-ID: <1188231535.15509.1207493335@webmail.messagingengine.com>
References: <20070827152359.GA22496@rifetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 013331038D8
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 18:18:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070827152359.GA22496@rifetech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jeremy Nickurak wrote:
> The mixer doesn't work at all w/linux kernel 2.6.22, everything is locked
> at 100% volume, which is pretty unhelpful, as it's the only way to adjust
> the volume. (no analog controls).

Are there any messages in the system log when you try to change them?

Please show the output of "lsusb -v" for this device.

> Also, the digital control panel

The remote control?

> locks up when the speakers power up, further preventing any access to
> the volume controls.

What does "lock up" mean?  Nothing happens when you press buttons?


Regards,
Clemens
