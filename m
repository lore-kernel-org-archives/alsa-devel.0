From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: how to handle bt848 audio driver
Date: Tue, 30 Oct 2007 12:26:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0710301224450.16052@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0710250407410.16052@shell4.speakeasy.net>
	<1193381218.13564.1217931615@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail5.sea5.speakeasy.net (mail5.sea5.speakeasy.net
	[69.17.117.7]) by alsa0.perex.cz (Postfix) with ESMTP id 7FF0624572
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 20:26:25 +0100 (CET)
In-Reply-To: <1193381218.13564.1217931615@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>, alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Oct 2007, Clemens Ladisch wrote:
> Trent Piepho wrote:
> > So, the ALSA driver (snd-bt87x) needs to use functions from the V4L driver
> > (bttv).  As it is now, the two drivers are completely separate and don't share
> > any code and can be loaded individually.
> >
> > The DVB driver in the same tree as bttv, so this isn't a problem.  But the
> > snd-bt87x is in another tree, so it's somewhat harder, and I'm not sure what
> > to do about it.
>
> The part of the ALSA API used by snd-bt87x is apparently more stable
> than the bttv functions to be used, so this seems to be a good
> opportunity to move snd-bt87x into the V4L tree.

What do you say about this Mauro?  From my perspective, it would be much
easier if all the bt848 drivers were in the same tree.
