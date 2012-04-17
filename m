From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsamonitor on SunOS
Date: Tue, 17 Apr 2012 09:25:30 +0200
Message-ID: <4F8D1AEA.4060802@ladisch.de>
References: <CAHymeZozhxD5uUBUsK0x7QzHdh-t3_ZTghwQTWEtp6kWeKwr7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3CC4A24365
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 09:22:20 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2405122CDA
	for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2012 03:22:19 -0400 (EDT)
In-Reply-To: <CAHymeZozhxD5uUBUsK0x7QzHdh-t3_ZTghwQTWEtp6kWeKwr7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: james pruett <gpscruise@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

james pruett wrote:
> I love the alsamonitor look and feel.

I assume you mean alsamixer?

> I want to port it to my SunOS box.
> Q: Is there a Hello World I might try first to see if the colors, etc work?

ncurses has demo programs.

> Q: what visual toolkit/gizmo is alsamonitor based upon?

alsamixer is based on curses with the panel and menu libraries; the actual
toolkit is written by hand (widget.c, textbox.c, etc.) and isn't very
generic:
http://git.alsa-project.org/?p=alsa-utils.git;a=tree;f=alsamixer;hb=HEAD


Regards,
Clemens
