From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: Query devices in a non-blocking fashion / 3D
	capabilties.
Date: Sun, 14 Dec 2003 15:06:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071428796.17638.21.camel@localhost>
References: <oprztqwoi4q1sf88@mail.broadpark.no>
	 <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com>
	 <20031208161936.310df2cb.pochini@shiny.it>
	 <oprzvc5mu3q1sf88@mail.broadpark.no>
	 <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz>
	 <oprzvh60rmq1sf88@mail.broadpark.no> <3FDC8D16.6070608@boosthardware.com>
	 <oprz6jjyl7q1sf88@mail.broadpark.no>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprz6jjyl7q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

While writing a advanced capabilities (positional audio) interface for
ALSA, i encountered this same problem.

So far i have "architected" the thing like this:

- The ALSA driver loads as usual.
- When OpenAL or whatever fires up, it queries the device for
capabilties, using a well defined control for that purpose.
- Depending on what capabilties are reported as supported, the library
uses a series of kcontrols to modify hardware settings for advanced
capabilties (HRTF, ITD, filters, etc).

If this can't be performed in a asyncronous (non-blocking) i wouldn't be
able to use controls.

I looked into "alsa-kernel/core/control.c" and after finding out that
every control interaction does a control lookup (iterated through all
controls), i don't feel very confortable about using kcontrols to update
hardware parameters in at tens of milisecond intervals.

Then i discovered the ALSA /proc interface, but the docs read "use for
debugging". They have a lot less overhead. Would it be OK to use them
for hardware parameter update ? And if so, why don't you use this
interface for queries ? They seem to give much more freedom about
locking and other issues.

I really need feedback :)

Best Regards

        
On Sun, 2003-12-14 at 12:46, Arve Knudsen wrote:
> On Mon, 15 Dec 2003 01:17:26 +0900, Patrick Shirkey 
> <pshirkey@boosthardware.com> wrote:
> 
> > If we have a DB of info how would we define the abilities of each device?
> >
> > I assume this info is available in the driver layer because there is a 
> > point where ALSA will return false eg. if a card is not able to run at 
> > 48000Hz
> >
> > My opinion is that a simple function could be included in alsactl which 
> > scans for available devices, makes a list of their abilities. Everyone 
> > uses "post-insert alsactl restore" in the modules.conf file so it would 
> > be essentially a non issue from a user perspective.
> >
> > Couldn't this be saved in the config settings for alsactl?
> This whole database thing seems like overkill to me, to be honest. This is
> dynamic information would best be obtained from cards during operation,
> the only problem is that you have to lock the device. A better design would
> be to, if possible, allow the configuration space to be read even when a
> device is streaming.
> 
> I dont know the dirty details of writing drivers, but would this be a
> problem? Perhaps we could differ between read-locked and write-locked
> configuration, so there would be inclusive read access to the device, and
> totally exclusive access if it is to be modified.
> 
> Hope some of this makes sense
> 
> Arve Knudsen
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
