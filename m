From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: static snd_pcm_uframes_t	snd_aicapcm_pcm_pointe
Date: Tue, 28 Feb 2006 09:20:21 +0100 (CET)
Message-ID: <XFMail.20060228092021.pochini@shiny.it>
References: <1141083326.9257.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141083326.9257.5.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 27-Feb-2006 Adrian McMenamin wrote:
> On Mon, 2006-02-27 at 12:35 +0100, Takashi Iwai wrote:
>
>>
>> The pointer callback can be at any time to query the current DMA
>> position, not only from the interrupt handler, e.g. from ioctl.
>>
>>
> What has DMA got to do with it? I am again confused.. I thought it was
> meant to return the current playback position, not the DMA position.

The ring buffer that holds audio data is accessed by your card
via DMA I guess.
.pointer(substream) shall return the position inside the buffer,
in frames, that the card is accessing in this moment. It's not
important whether the card uses DMA or it doesn't.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
