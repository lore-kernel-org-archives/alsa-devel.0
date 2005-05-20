From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: ALSA PCM DMA questions
Date: Fri, 20 May 2005 10:53:03 +0200 (CEST)
Message-ID: <XFMail.20050520105303.pochini@shiny.it>
References: <083AB380E3924D4795740AAE9A27DCABDB962B@cgy2000.interalia.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <083AB380E3924D4795740AAE9A27DCABDB962B@cgy2000.interalia.ca>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Derek Jones <DJones@Interalia.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 19-May-2005 Derek Jones wrote:

> After the DMA transfer completes, I call snd_pcm_period_elaped(substrea=
m).
> I'm guessing that this moves a buffer pointer. What I cannot figure out
> is how to determine where I am in the buffer so that I can start the ne=
xt
> DMA from the correct position.

Does your hw require restart the DMA after each block ?  This is bad. It'=
s
nearly impossible to do that without a small delay. BTW, the hw should
provide a way to know what it is playing/recording. It it doesn't, you ha=
ve
to count IRQs. If you have to restart the DMA every time, it's simple: ju=
st
store the current block number when you start it for later use.


> When the entire buffer has been DMA'ed, is the buffer overwritten with =
new
> PCM data from userland

During playback, part of the buffer (one or more periods) is filled with
new data. snd_pcm_period_elapsed() triggers it.


> or does the DMA buffer work like a circular buffer with userland data
> being transferred into the buffer at each PCM period.

Yes.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
