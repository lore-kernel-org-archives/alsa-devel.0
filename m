From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 03:44:34 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110334250.5612-100000@ecabase.localdomain>
References: <20030711002824.GB21433@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030711002824.GB21433@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

One more post - I'll promise this is the last one. :)

On Fri, 11 Jul 2003, Carlo Wood wrote:

> That gives rather strange output:

But it's not stopping...? That's at least different behaviour...

> It doesn't feel right to read bytes when it says
> that there are no fragments/bytes available.

That's true, but as the read() is blocking it will wait 
until there is data available before returning.

> Is the average bytes/second correct though?
[...]
> Number of channels: 1
> Sample rate: 22050
> and AFMT_S16_LE, what should it be?  I am not so good
> at calculating things without knowing the unity of the
> 'rate' ;)... bits/s?  Byte/s?  (16-bit)Words/sec?

Hmm, not quite - you are reading 16bit samples at a rate of 22050 per sec, 
so the data rate should be 22050*16/8=44100 bytes per second.

But the rate actually is 8000 (you can check this by catting
/proc/asound/card0/pcm0c/sub0/hw_params). In your  code:

res = 22050;
if (ioctl(fd, SOUND_PCM_READ_RATE, 0xbfffdcfc) == -1)
{
   perror("ioctl");
   exit(1);
}
printf("Sample rate: %d\n", res);

... 'res' is always 22050 no matter what the device reports.
So with 8000, the date rate should be 16000 bytes/sec.

> Anyway, it seems too low or too high.
> When I add back the "if (info.fragments > 0)" test
> and decrease the naptime drastically, I get:

Try my other change to the test code - i.e. only sleep for
naptime when info.fragments is zero.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
