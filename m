From: Friedrich.Ewaldt@gmx.de
Subject: CS46xx 4 channel?
Date: Thu, 18 Jul 2002 12:16:03 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <12392.1026987363@www3.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I've just found the following message at the vmlinuz mail archive:

*****************
My sound card is a Hercules Fortissimo II (Cirrus Logic CrystalClear 
SoundFusion Audio Accelerator CS4624).

The are three problems to be addressed:

1. I am know using the kernel oss driver, and it works nice; except for 
the mixer channel labeling. 'mixctlr' segfaults, but 
'gnome-volume-control' works fine. The problem is that the main volume 
control controls the front speakers while the 'pcm' controls the main 
volume and 'pcm2' the read speakers.

2. The alsa driver only works in 2-channel mode. Does anyone here knows 
an alsa guy and can forward the info the the kernel driver already 
supports 4-channels?

3. The headphones output does not work with either driver, even though 
there is a control for it on the kernel drivers.

Thanks.

--
Eugenio Diaz, BSEE/BSCE
Linux Engineer
getnito@yahoo.com
****************
So, my quetion is:
Is there a chance to get 4 channel output working on the cs4624 now?
That would be great.

Thanks,
fritz_e




-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
