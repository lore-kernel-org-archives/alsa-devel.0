From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 17:04:00 +0200
Message-ID: <4E70C260.3040001@ladisch.de>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 13DBE24337
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 17:03:47 +0200 (CEST)
In-Reply-To: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Crowe <drmikecrowe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mike Crowe wrote:
> Apologies if this is obvious, but how does the OSS emulation layer set
> hardware parameters at the codec level?

Just like any other client, by calling the driver's hw_params function.

> When my OSS application opens it's device and changes the audio rate,
> I don't see that function getting called.

Does the changing of the rate actually succeed?


Regards,
Clemens
