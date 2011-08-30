From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa timing question
Date: Tue, 30 Aug 2011 09:49:56 +0200
Message-ID: <4E5C9624.6040405@ladisch.de>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>	<4E55F6A2.3040307@ladisch.de>
	<CAE3TgXHTshARnB8oYssGnU4gD1K1jCa2J-VX0OGhuqZ375RQAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D104D24503
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 09:49:52 +0200 (CEST)
In-Reply-To: <CAE3TgXHTshARnB8oYssGnU4gD1K1jCa2J-VX0OGhuqZ375RQAQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
>> However, if you're using the dmix plugin, the period size of your
>> application's device will not necessarily be identical with the period
>> size of the hardware device.
> 
> Would dmix allow me to control this better than pulse audio?

These parameters must be chosen by dmix before the first dmix device is
used, so applications cannot control them directly.

The defaults for dmix's period_size, period_time, and periods are 1024,
-1, and 16.  They can be overridden by setting the configuration values
defaults.dmix.DRIVER.period_size/period_time/periods, where DRIVER is
the internal driver name (the name between the colon and the hyphen in
/proc/asound/cards, or the file name in /usr/share/alsa/cards/).


Regards,
Clemens
