From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Understanding JACK's inner loop?
Date: Wed, 10 Dec 2003 12:56:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprzyrf8gwq1sf88@mail.broadpark.no>
References: <000001c3bef9$09182fa0$264440ab@roboserv1>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000001c3bef9$09182fa0$264440ab@roboserv1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rcassidy@stanford.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, Ryan

If you're interested in the mechanics of full duplex memory-mapped i/o
with ALSA-lib you could always check out PortAudio v19 CVS at
www.portaudio.com, which implements both a blocking and callback interfac=
e.
If you're interested specifically in JACK interfacing with ALSA-lib I
would think alsa_driver.c would be the place to look.

Hope this helps

Arve Knudsen

On Wed, 10 Dec 2003 00:38:50 -0800, Ryan Cassidy <rcassidy@stanford.edu>=20
wrote:

> Hello all,
>
> I am trying to understand the specifics of the mechanism that JACK uses
> to perform audio duplexing (simultaneous playback and capture of audio)=
.
> I have downloaded the latest source from CVS.  Is the file
> 'alsa_driver.c' a good place to start (i.e. is this where the magic
> happens)?  Does JACK use memory-mapped read/write?
>
> Any info. greatly appreciated.
>
> Cheers, rjc.
> --
> Ryan Cassidy
> Electrical Engineering Graduate Student, CCRMA Researcher
> Stanford University
> E-mail: ryanc@ieee.org
>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
