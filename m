From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 1.0.16rc2
Date: Fri, 1 Feb 2008 23:15:55 +0000
Message-ID: <20080201231555.91114bd5.pochini@shiny.it>
References: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
	<20080131233848.35bb5071.pochini@shiny.it>
	<s5hsl0d2e4y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 3954010390F
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 22:58:19 +0100 (CET)
In-Reply-To: <s5hsl0d2e4y.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 01 Feb 2008 10:57:01 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> > I have a little compile problem. It seems that the configure
> > script of alsa-lib isn't able to locate the directory with the Python
> > headers. I have to either disable python support, or do "export
> > CFLAGS=-I/usr/include/python2.4".
>
> Does --with-pythonincludes=/usr/include/python2.4 work?

Yes, of course.


> Usually /usr/include/python is a symlink to python$VERSION directory.

No, the bug was in the python-config script.


--
Giuliano.
