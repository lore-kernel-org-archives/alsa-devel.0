From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What's the right way to do??? resample??
Date: Fri, 1 Apr 2005 11:04:55 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504011047420.1643-100000@studcom.urz.uni-halle.de>
References: <7fe20599050331173415fe08ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7fe20599050331173415fe08ac@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joe Hsu <nagual.hsu@gmail.com>
Cc: Dirk Jagdmann <doj@cubic.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Joe Hsu wrote:
> On Thu, 31 Mar 2005 16:36:15 +0200, Dirk Jagdmann <doj@cubic.org> wrote:
> > You have to sync your hardware for input and output. That either means
> > you have to use a hardware which provides both input and output and full
> > duplex access or you have to use an external word clock cable to
> > synchronisation. Then on the software side you can be sure, that your
> > output will always consume the exact amount of data the input has just
> > generated.
>
> Actually I record from bt878 and play it back on AC97. So
> what do you mean by "external world clock" in this case?

In this case, there is no word clock; the hardware would have to
support it.

> Or you just mean there is no solution without hardware
> modifications in such a case??

You could either connect the TV card's analog output to the line in of
the AC97 so that both recording and playback use the same clock, or
you could convert the sample rate in software.  Most existing
libraries like e.g. libsamplerate assume that you know the exact
sample rate in advance, so you would have to write your own sample
rate converter that can adjust it ratio dynamically.


Regards,
Clemens



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
