From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 08:18:07 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045498687.3e510b3fb134e@webmail3.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: T.Motylewski@bfad.de
Cc: perex@suse.cz, abramo.bagnara@libero.it, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>Well, but when adding a+b we have no idea that that overlow will be compensated
>by next very big negative sample. Also mixing signals which already fill 90% of
>dynamic range is not a good idea. My "fix" is heuristic - it works for
>occasional _small_ overflows like 0x4100+0x4000 -> 0x7fff is much better than
>0x8100. 
>
>The idea of dmix as I understand it is that buffer is already in the native
>format for the sound card. So if sound card supports 24 bit, OK. But then
>people will start mixing 24 bit samples :-)
>
>> AFAIK most hardware does not mix by reducing volume before the sum. On the
>> contrary, it is usually summed "as is" to a wider register, and often even so
>
>And here our "wider register" is 16bit. That means end users should not expect
>too much if thay mix full power signals on it.
>
>BTW. If you have uncorrelated signals, then to mix 4 signals it may be good
>enough to reduce the amplitude of them just factor 2, because power will drop
>factor 4. Ocassionally there will be overrruns, but 0x7fff limit will make it
>almost not hearable. Not a correct fix, but I can assure you that it works in
>standard cases :-)

That's a good point. As long as we're dealing with 2 or 3 channels we probably
can do with saturating. But we should consider adding a shift right by one
(after adding, before saturation) once we have 4 channels, by two at 8 
channels, or something similar.
Otherwise we will start getting some ugly clipping artifacts. The problem is,
this can cause a (noticable) sudden drop in volume when a "threshold" client
connects/disconnects. We could ramp, but that's a multiplication...

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
