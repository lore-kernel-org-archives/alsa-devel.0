From: Benny Sjostrand <gorm@cucumelo.org>
Subject: More CS4630, secondary CODEC output.
Date: Sat, 27 Jul 2002 01:01:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D41D4DC.60004@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA02853
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 01:52:49 +0200
Received: from cucumelo.org (cactus [194.236.61.89])
	by cucumelo.org (Postfix) with ESMTP id E58C72F46D
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 01:01:48 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again!

Seems there's quite big interest in the cs46xx stuff. Finally i've been 
able to have output from
the rear channel on the secondary CODEC. For the moment the output are 
same on both
rear and front channels, but it's possible to create a secondary .WAV 
device and
transfer two independent DMA channels to front and rear, and I believe 
that I know
how to do that, but that will require some more work and some drastic 
changes in cs46xx_lib.c.

It was not easy to find out how to probe and speak to the secondary CODEC,
it has to be done different with AC97 2.0 and AC97 1.03 codecs, on AC97 1.03
I believe that codec_write && codec_read fucntions cant be the same so 
for the moment
(probably) only cards with AC97  2.0 codecs will work. I've only tested 
this with "Hercules Game Theater",
probably there will be a lot of strange behaviours with other soundcards.

Now the "Game Theater XP" got two CS294 codecs, and now the ALSA mixer 
got two elements
of almost everything, where about a 70% of all controls in the mixer are 
probably totally meaningless,
controlling stuffs that are not conected to CODEC any suggestions about 
what to do with this ???
It dont not feel necesary to have two Master volumes ...

Heres my new snaphot, you are welcome to test it out:
http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020727.tar.gz
http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020727.diff.gz

/Benny





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
