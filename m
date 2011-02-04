From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] how to cross compile the alsa util?
Date: Fri, 04 Feb 2011 14:22:52 +0100
Message-ID: <4D4BFDAC.8070105@ladisch.de>
References: <4D4BF986.8030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 44F50103B0C
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 14:22:49 +0100 (CET)
In-Reply-To: <4D4BF986.8030603@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leonid <leonopulos@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Leonid wrote:
> checking for ncursesw5-config... yes
> checking for curses library... ncursesw
> checking for curses header name...<ncurses.h>
> checking for curses compiler flags... -I/usr/include/ncursesw
> ...
> checking for panel.h... no
> configure: error: required curses helper header not found

Alsamixer also requires the panel and menu libraries.  These are part
of ncurses; check whether they are included in your ncurses package, or
maybe available as separate -dev packages.

You could also disable alsamixer.


Regards,
Clemens
