From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: init script with hotplug & usb audio
Date: Fri, 27 Sep 2002 09:08:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209270908.41909.baldrick@wanadoo.fr>
References: <200209261020.25769.baldrick@wanadoo.fr> <s5hr8fhm0mg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr8fhm0mg.wl@alsa2.suse.de>
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

On Thursday 26 September 2002 13:49, Takashi Iwai wrote:
> At Thu, 26 Sep 2002 10:20:25 +0200,  Duncan Sands wrote:
> > I have a usb webcam with audio plugged into my computer,
> > and a cs46xx sound card inside.
> >
> > When I boot the following sequence occurs:
> >
> > (1) the hotplug subsytem is started.  This automatically
> > loads the snd-usb-audio module and the modules it
> > depends on.  In particular /proc/asound/ is created.
> >
> > (2) the alsasound init script is run.  It detects that
> > /proc/asound/ exists, and exits at once.  In particular
> > it does not restore mixer levels for the cs46xx card.
> >
> > I solved this by commenting out the check for /proc/asound/
> > in the init script.  The problem goes deeper though, especially
> > when things like usb audio devices are around, which can be
> > hotplugged: maybe sound card modules should really be calling
> > the hotplug subsystem when they are initialize.  The hotplug
> > script would then restore mixer settings etc...
> >
> > Thoughts?
>
> i solved like the following:
>
> - add snd-usb-* (and oss audio module) to hotplug's blacklist
>   to avoid to load them from the modules.usermap.
> - add a usermap for the usb audio devices to call its own start-up
>   script.  the script starts the alsasound init script inside before
>   loading the snd-usb-audio module (if no /proc/asound exists), so
>   that it asssures that the normal PCI devices are assigned prior to
>   usb devices.

Thanks for the info.  I still think it's a bandaid though: the real problem
is that the logic in the init script is broken.  Anything that causes modules
to be loaded before the init script is run breaks the script, as far as I can
see.  For example: compiling into the kernel, i.e. not as modules ; using
hardware detection software that autoloads sound card drivers ; using usb
audio...  In these cases /proc/asound will exist when the init script is run,
and mixer settings will not be restored, card specific scripts will not be run etc.

In the long term (2.6 kernel) I am imagining the following:

(1) the init script just loads modules.
(2) when modules are loaded, whether for a pci card, a usb one whatever,
the hotplug subsystem is called: it restores mixer settings for the card and
runs card specific scripts.

In the short term a quick hack will do of course.

Thanks for your help,

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
