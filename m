From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: USB devices should not oops after disconnect now
Date: Wed, 27 Nov 2002 12:06:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271157460.532-100000@pnote.perex-int.cz>
References: <3DE4A184.4020706@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA03924
	for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2002 21:44:56 +0100
In-Reply-To: <3DE4A184.4020706@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Patrick Shirkey wrote:

> Jaroslav Kysela wrote:
> > 
> > Note that you'll have to terminate all applications using that soundcard
> > before you'll try to reconnect the device again. In next code, hopefully
> > the applications will be somehow terminated to make the cleanup process
> > automatic.
> > 
> 
> 
> Ok. That's the probable cause as I am having problems with jack not 
> releasing the device.
> 
> It seems that hotpluging out is a tricky issue because we have to decide 
> whether the application/s that are using the device should also be 
> terminated.
> 
> Is it possible to transparently swap snd-usb-audio with snd-dummy if it 
> has been installed? That could be a secondary default if people would 

It's too complicated and probably an overdesign. Also, what to do, if
another hardware is plugged to the system than previous one? The full
handshake between driver and application have to be triggered all times
(old "disconnected" file descriptors have to be closed).

> prefer their apps do not automatically segv.

We have two choices:

1) terminate all applications using a signal (SIG_KILL or SIG_TERM)
2) disable all operations with a file descriptor and give an error code
   to applications when disconnect occured so they can decide what to 
   do - terminate - or wait until hardware is not available again - (this
   is my goal)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
