From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: init script with hotplug & usb audio
Date: Tue, 1 Oct 2002 08:46:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210010846.15464.baldrick@wanadoo.fr>
References: <200209261020.25769.baldrick@wanadoo.fr> <200209300955.14788.baldrick@wanadoo.fr> <s5hheg7lrnw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hheg7lrnw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Another point to keep in mind here, is that a lot of people are now
> > using journaled filesystems, and may just turn off the computer
> > without shutting down.  You could say that they deserve what they
> > get, but I'm not so sure.  Imagine someone using alsamixer to change
> > mixer settings.  They quit alsamixer then turn off the machine.  Are
> > they wrong to expect the mixer settings to still be there on reboot?
>
> yes.  the infromation will be lost.
>
> > After all, they "saved the settings" when they left alsamixer didn't
> > they?
>
> no, the setting is on memory, thus not saved when you turn the power
> off.  he can run "alsactl store" manually (or write a equivalent
> wrapper script for alsamixer) instead.
> but this should not be standard, i think.

Too costly?

Just to be clear: I know that the mixer information will be lost, I was just trying
to point out that the current behaviour is not what people might reasonably expect.

Ciao,

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
