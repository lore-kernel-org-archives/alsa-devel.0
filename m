From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Parsing asoundrc for devices.
Date: Wed, 26 Feb 2003 21:57:44 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302262119440.1114-100000@pnote.perex-int.cz>
References: <3E5D04E9.7020900@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E5D04E9.7020900@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Feb 2003, Patrick Shirkey wrote:

> Paul Davis wrote:
> >>I don't quite follow this. Is that a fictional call which an app could 
> >>use to get these details or is it an already functioning piece of code 
> >>that I haven't seen in action?
> > 
> > 
> > the latter.
> > 
> 
> Sorry to be lame but...
> 
> Does anyone know if it is used in any apps that I might have in my 
> system or have I not seen it in action because no one uses it yet?

It's not an easy task when you have a lot of virtual devices with more 
configurable parameters. Also you may pass one virtual device to another, 
this chaining makes things more and more complicated for the end user.

I think that we need to discus what is the best solution for this 
purpose. My idea is to create a nice graphical tool which will parse and 
manage the .asoundrc file. Then it creates a list of devices with easy 
syntax which will be accessible via alsa-lib functions. In this way, the 
default predefined devices will be available to standard users and 
more skilled users will use the graphical tools. Gurus may modify 
.asoundrc file by hand, of course ;-)

Unfortunately, I and Takashi have no power to create such graphical tool.
We can probably add some default list of devices and create the alsa-lib's 
functions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
