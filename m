From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ice1712 noise
Date: Sat, 31 Jan 2004 11:26:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401311125130.1876@pnote.perex-int.cz>
References: <20040131060928.GA27876@ice_nine.wi.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040131060928.GA27876@ice_nine.wi.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anthony <avan@uwm.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 31 Jan 2004, Anthony wrote:

> Hi, I've been hearing for some weeks now a very high
> frequency, quiet crackling distortion when using my
> delta44 on playback. This is with driver versions
> 0.9.8 and 1.0.2.
> 
> Symptoms:
> * It only occurs on playback.
> * It is not always present, but once it manifests
>   it is consistent.
> * I've ruled out external gear by swapping everything
> * It cannot be recorded...i.e. if i use jack capture
>   while it is happening, and playback on my other
>   card I do not hear it
> * I have been able to reproduce it with alsaplayer
>   using the hardware layer (so not a jack problem).
> * shutting down alsa apps and restarting the drivers
>   fixes the problem until it reoccurs. It can take
>   a long to to resurface.
> * Of course, there is no way for me to rule out the
>   card itself as being the problem.
> * Other than driver changes, my system has been
>   a rather stable 2.4.21 kernel.

It looks like that something is wrong with DACs.
Does the noise occur on all outputs?

				 	Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
