From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 14 Dec 2003 17:46:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprz6jjyl7q1sf88@mail.broadpark.no>
References: <oprztqwoi4q1sf88@mail.broadpark.no> <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com> <20031208161936.310df2cb.pochini@shiny.it> <oprzvc5mu3q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz> <oprzvh60rmq1sf88@mail.broadpark.no> <3FDC8D16.6070608@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FDC8D16.6070608@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Dec 2003 01:17:26 +0900, Patrick Shirkey=20
<pshirkey@boosthardware.com> wrote:

> If we have a DB of info how would we define the abilities of each devic=
e?
>
> I assume this info is available in the driver layer because there is a=20
> point where ALSA will return false eg. if a card is not able to run at=20
> 48000Hz
>
> My opinion is that a simple function could be included in alsactl which=
=20
> scans for available devices, makes a list of their abilities. Everyone=20
> uses "post-insert alsactl restore" in the modules.conf file so it would=
=20
> be essentially a non issue from a user perspective.
>
> Couldn't this be saved in the config settings for alsactl?
This whole database thing seems like overkill to me, to be honest. This i=
s
dynamic information would best be obtained from cards during operation,
the only problem is that you have to lock the device. A better design wou=
ld
be to, if possible, allow the configuration space to be read even when a
device is streaming.

I dont know the dirty details of writing drivers, but would this be a
problem? Perhaps we could differ between read-locked and write-locked
configuration, so there would be inclusive read access to the device, and
totally exclusive access if it is to be modified.

Hope some of this makes sense

Arve Knudsen




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
