From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Decibel
Date: Mon, 14 Nov 2005 16:23:17 +0000
Message-ID: <ad2655cb0511140823g4eb97737o@mail.gmail.com>
References: <43789BEC.9000509@e4a.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43789BEC.9000509@e4a.it>
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
To: Dino Puller <dino@e4a.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 14/11/05, Dino Puller <dino@e4a.it> wrote:
> Hi all,
>   only a simple  question:  How to obtain min_dB value for my device or
> pcm channel? I found the api snd_mixer_selem_get_playback_dB_range but i
> didn't understand how to use it. Is it the right api? I've found also
> sndo_mixer_io_get_dB i'm a bit confused.
>
> thanks,
>   Dino Puller
>

Those api commands are not supported yet. The alsa-lib to user
application api is there and fixed. The support needs to be added to
alsa-driver and some modifications to alsa-lib to make it work. I am
working on it.

James


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
