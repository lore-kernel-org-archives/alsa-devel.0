From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [Alsa-dev]detecing if a device is already used by an other app
Date: Wed, 26 May 2004 09:46:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xbrkb8wc8.fsf@kth.se>
References: <40B447C0.5020200@atr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Cournapeau David <cournape@atr.jp> writes:

> Hi there,
>
>     I am currently using two computers which have a crappy intl8x0
>     audio chipset, and these chipset cannot be used by two different
>     apps in the same time. For example, if an audio app is using the
>     soundcard, trying to launch xmms ( with alsa output plugin) gives
>     an error message which says something like "check that no other
>     app is blocking the device". But if I launch alsaplayer (alsa
>     output plugin) instead of xmms, the app doesn't complain: it
>     'just' blocks on the snd_pcm_open call.
>     Basically, after having looked at the source, is seems like this
>     difference is coming from the flag in snd_pcm_open: if
>     SND_PCM_NONBLOCK  is used, opening an already opened device
>     failed, if SND_PCM_ASYNC is used, the app just blocks, until the
>     other app releases the device.

This is correct.

>     Is there a (simple) way to use the blocking call and detecting if
>     the device is already opened ?

You can open it in non-blocking mode and set it to blocking later, if
you want that behavior when writing data.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
