From: Raymond Toy <rtoy@google.com>
Subject: Re: Alsa timing question
Date: Tue, 30 Aug 2011 12:04:33 -0700
Message-ID: <CAE3TgXE9tQPFZi5bUYkpkTQ4PC1Fh2FmHngrxLg+jWJ3a3_8WA@mail.gmail.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
	<4E55F6A2.3040307@ladisch.de>
	<CAE3TgXHTshARnB8oYssGnU4gD1K1jCa2J-VX0OGhuqZ375RQAQ@mail.gmail.com>
	<4E5C9624.6040405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FCF01037F3
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 21:04:41 +0200 (CEST)
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com
	[172.24.198.77]) by smtp-out.google.com with ESMTP id p7UJ4e1Z008328
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 12:04:40 -0700
Received: from fxd23 (fxd23.prod.google.com [10.184.4.23])
	by wpaz13.hot.corp.google.com with ESMTP id p7UJ4X3T014421
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 12:04:38 -0700
Received: by fxd23 with SMTP id 23so6085364fxd.26
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 12:04:33 -0700 (PDT)
In-Reply-To: <4E5C9624.6040405@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2011 at 12:49 AM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Raymond Toy wrote:
> >> However, if you're using the dmix plugin, the period size of your
> >> application's device will not necessarily be identical with the period
> >> size of the hardware device.
> >
> > Would dmix allow me to control this better than pulse audio?
>
> These parameters must be chosen by dmix before the first dmix device is
> used, so applications cannot control them directly.
>
> The defaults for dmix's period_size, period_time, and periods are 1024,
> -1, and 16.  They can be overridden by setting the configuration values
> defaults.dmix.DRIVER.period_size/period_time/periods, where DRIVER is
> the internal driver name (the name between the colon and the hyphen in
> /proc/asound/cards, or the file name in /usr/share/alsa/cards/).
>
>
Thanks for the info.  Can this be done programmatically?  I've done some
tests using dmix by setting up my .asoundrc appropriately, and dmix works
very nicely once I got the dmix period size and buffer size to agree with my
application.  However for the application, I don't want to have to tell the
user to set up dmix.  (Yes, I know this is not nice, but we're doing this
for testing right now, to make it easier for users to test this.)

Thanks,

Ray
