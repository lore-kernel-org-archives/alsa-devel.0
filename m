From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 04:03:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030711020353.GA27925@alinoe.com>
References: <20030711002824.GB21433@alinoe.com> <Pine.LNX.4.44.0307110334250.5612-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307110334250.5612-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 11, 2003 at 03:44:34AM +0300, Kai Vehmanen wrote:
> Hmm, not quite - you are reading 16bit samples at a rate of 22050 per sec, 
> so the data rate should be 22050*16/8=44100 bytes per second.

Ok

> But the rate actually is 8000 (you can check this by catting
> /proc/asound/card0/pcm0c/sub0/hw_params). In your  code:
> 
> res = 22050;
> if (ioctl(fd, SOUND_PCM_READ_RATE, 0xbfffdcfc) == -1)
> {
>    perror("ioctl");
>    exit(1);
> }
> printf("Sample rate: %d\n", res);
> 
> ... 'res' is always 22050 no matter what the device reports.

Ugh.  Now I am confused.  Since this is a speech recognition
program, I suppose it will perform a fourier transform (fft)
on the data.  When it expects a rate of 22050 (it requested
that and the ioctl confirmed it) then it will treat the data
as if it was 2.76 times higher in frequency then it actually
is!  That could lead to it not being able to understand the
spoken words, no?

> So with 8000, the date rate should be 16000 bytes/sec.

Ok, thats what I get more or less without any xruns.

> > Anyway, it seems too low or too high.
> > When I add back the "if (info.fragments > 0)" test
> > and decrease the naptime drastically, I get:
> 
> Try my other change to the test code - i.e. only sleep for
> naptime when info.fragments is zero.

That leads to no xruns, then it works.
It is of no use however because I can't get the closed
source application to read faster ;).

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
