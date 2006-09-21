From: Junji Umeno <umeno@elwsc.co.jp>
Subject: Can't set less than 48k rate in the
	Intel-ICH4	(AD1981B)
Date: Thu, 21 Sep 2006 13:05:46 +0900
Message-ID: <20060921130546.02f871fe@localhost.localdomain>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I can't set less than 48kHz rate for capture sampling.
In my case,
Alsa prepares 4 pcm devices, 
and I use the first 0-0 and the 4th 0-3, each playback and capture.
But when I set to the 3rd less than 48k rate, 
Alsa shows error,"cannot set sample rate".
On the other way, 
the 1st can be set less than 48k rate as a capture port. 
Playback use is no problem.

The Intel ICH4 in my laptop TP/R50e seems to have Analog Devices AD1981B as AC'97 Codec, alsamixr says. 

AD1981 spec sheet
http://www.analog.com/en/prod/0,2877,AD1981B,00.html

With the "PCM ADC RATE REGISTER" in the spec sheet,
we can be supported of from 7k to 48k rate.

What does Alsa do for that?
Does anyone knows ?

Thanks,
Junji

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
