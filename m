From: Richard Smith <smithbone@gmail.com>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Fri, 28 Oct 2005 13:34:16 -0500
Message-ID: <8a0c36780510281134gce42934v61b094b072d8f841@mail.gmail.com>
References: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
	 <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> The driver has always supported full speed devices; the somewhat
> recent changes are for high speed devices (which the Audiophile
> isn't).

Ah.  Ok.

Well.  I'm not sure what fairy visited me but I'm haveing much better luck =
now.

arecord does S24_3BE fine if you use -t raw. Its writeing to a .wav
that won't support that format.

I can now do the arecord | aplay for many different formats using both
plughw and hw and it all works.

arecord | aplay @ S24_3BE/96k still gives lots of static but now I can
acutally hear the source.  However if I do an arecord to a (raw) file
and then aplay back that file it works.

Next I tried to get jackd up but jackd dosen't like S24_3BE and if I
use plughw I get XRUNS.

> What are the contents of /proc/asound/card0/stream0?

I'm away till Sunday.  So I'll post it then.  I'm not having a lot of
luck with the oops ether.  ksymoops wants to look for  /proc/ksyms but
I don't seem to have one.  I have a /proc/kallsyms that looks like
something useful but ksymoops complains its not a useable format.

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
