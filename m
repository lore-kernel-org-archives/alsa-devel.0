From: Cournapeau David <cournape@atr.jp>
Subject: Re: Question regarding period/buffer and error handling
Date: Fri, 28 May 2004 17:00:32 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B6F1A0.4080704@atr.jp>
References: <40B6970F.90507@atr.jp> <yw1x1xl5rq3g.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1x1xl5rq3g.fsf@kth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

M=E5ns Rullg=E5rd wrote:

>
>If you are playing fairly short pieces of sound you might be able to
>use this function I wrote some time ago:
>
>function playsnd(y,fs,bits)
>
>wf =3D tempname;
>ws =3D warning;
>warning off
>wavwrite(y, fs, bits, wf);
>warning ws
>wf =3D [wf '.wav'];
>[s,o] =3D unix(sprintf('aplay %s', wf));
>delete(wf);
>
>
> =20
>
Well, I precisely want to avoid writing to a temporary file :)

But right now, my function seems to work, I just used UNIX signals to=20
close cleanly the audio device, it was much simpler than what I thought=20
at first.

Cheers,

David


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
