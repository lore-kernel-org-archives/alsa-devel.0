From: Rafal Dejewski <lardel@interia.pl>
Subject: Ali5451 problem with mixer
Date: Sat, 14 Dec 2002 13:04:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212141304.40416.lardel@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I have a problem with alsa mixer on kernel 2.5.51 and alsa-lib, alsa-utils 
0.6rc6. Whenerver I try to run alsamixer the following message appers in 
console and alsamixer would not start:
$ alsamixer
ALSA lib simple.c:944:(simple_add1) helem (MIXER,'IEC958 Playback 
Switch',0,0,0) appears twice or more
alsamixer: function snd_mixer_load failed: Invalid argument

I found out that disabling this check in simple.c in alsa-lib allows alsamixer 
to run and work (well, for me). 
Unfortunatelly I can't test spdif connection. Oss emullation mixer works ok. 
This happens also with ali5451.c rev.1.23 from cvs.
This problem was also reported here: 
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg05094.html

Help appreciated,
Rafal

----------------------------------------------------------------------
Narysuj swoje wlasne logo na komorke! >>> http://link.interia.pl/f16a7




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
