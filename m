From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: How to read the sound card ?
Date: Mon, 31 Jul 2006 09:23:14 +0200
Message-ID: <44CDAFE2.4020406@purplelabs.com>
References: <44CCBDCC.2010109@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44CCBDCC.2010109@free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Micha=EBl_Todorovic?= <michael.todorovic@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I think the simpler way is to write a plugin for alsa, which will take
place in the plugin chain, just before outputing the sound.
The last time i did that, you couldn't do it if using softmix (which has
to be directly plugged to hw) but maybe it's possible now...
There is a doc written on how to write an ALSA plugin, that should help
you do that ;)

Regards,

-- Ben


Micha=EBl Todorovic wrote:

>hello,
>I want to read the data on the sound card (to do a fft and other =

>things). I have first tried the capture stream with snd_pcm_readi and =

>everything is working. My problem is that I want to read the sound =

>output (pcm or mixer). For example, I want to read the sound that xmms =

>or mplayer is writing on the sound card. If I just change =

>SND_PCM_STREAM_CAPTURE to SND_PCM_STREAM_PLAYBACK in snd_pcm_open, =

>snd_pcm_readi fails.
>
>So my question is : how can I read the sound output with the alsa-lib ?
>
>Thank you
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share yo=
ur
>opinions on IT & business topics through brief surveys -- and earn cash
>http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DD=
EVDEV
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>  =

>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
