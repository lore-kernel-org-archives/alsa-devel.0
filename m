From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: mixer callback - help needed
Date: Wed, 28 Jun 2006 19:14:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606281914050.9366@tm8103.perex-int.cz>
References: <b6251a620606271122g286b33a7tdba872519b8b7e70@mail.gmail.com>
	<s5h8xnhqk5x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xnhqk5x.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Christophe Osuna <christophe.osuna@gmail.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Jun 2006, Takashi Iwai wrote:

> At Tue, 27 Jun 2006 20:22:04 +0200,
> Christophe Osuna wrote:
> > 
> > Hi,
> > 
> > I am trying to implement a simple mixer. Changing volume is fine but I
> > am stuck with the callback for mixer events.
> > 
> > I couldn't find lots of documentation, so I have tried to mimic what
> > is done in alsamixer. However I must have missed something because it
> > does not work. I only call snd_mixer_set_callback; it seems it is not
> > enough but what else is needed?
> > 
> > Below is a program just to show what I am trying to do. Could anyone
> > give me hand with this?
> 
> You need to call snd_mixer_handle_events() to trigger callbacks.
> 
> Usually you wait via poll() or select() (with pollfd parameters
> returned from snd_mixer_poll_descriptors()) then call
> snd_mixer_handle_events().

An example code is in alsa-utils/amixer/amixer.c - events() and sevents() 
routines.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
