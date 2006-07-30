From: =?ISO-8859-1?Q?Micha=EBl_Todorovic?= <michael.todorovic@free.fr>
Subject: How to read the sound card ?
Date: Sun, 30 Jul 2006 16:10:20 +0200
Message-ID: <44CCBDCC.2010109@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello,
I want to read the data on the sound card (to do a fft and other 
things). I have first tried the capture stream with snd_pcm_readi and 
everything is working. My problem is that I want to read the sound 
output (pcm or mixer). For example, I want to read the sound that xmms 
or mplayer is writing on the sound card. If I just change 
SND_PCM_STREAM_CAPTURE to SND_PCM_STREAM_PLAYBACK in snd_pcm_open, 
snd_pcm_readi fails.

So my question is : how can I read the sound output with the alsa-lib ?

Thank you

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
