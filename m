From: "thewade" <pdman@aproximation.org>
Subject: Re: Change of iomem types
Date: Mon, 20 Sep 2004 15:20:28 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409202120.i8KLKSEL027402@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > I answered my own question (I thought).
> > I checked out the CVS version of alsa and copied the alsa-kernel contents to 
> > linux/sound
> > but when I compiled I get this, any ideas why? Thanks!
> 
> Apparently, you didn\'t copy the header files to linux/include/sound.
> Also, the alsa-kernel tree is kept for the very recent linux-kernel
> version (2.6.9-rc2) only.  So, this way won\'t work for you anyway.

As usual you are correct Mr. Iwai. I downloaded and patched 2.6.8.1 to 2.6.9-rc2 and copied the alsa-kernel contents to sound and alsa-kernel/include to include/sound but now it doesnt detect the cardbus on boot and running hdsploader freezes my machine.

You had mentioned that you merged your iomem code with the kernel; if I
download and patch kernel 2.6.8.1 to 2.6.9-rc2-bk6 will I then have the
iomem code in the kernel?

Thanks for your work and your patience with newbies like me whos coding
skills cannot save themselves.

-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
