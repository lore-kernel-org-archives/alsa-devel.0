From: "thomas.luo" <thomas.luo@ieee.org>
Subject: meet trouble in user the ALSA?
Date: Fri, 22 Dec 2006 14:37:06 +0800
Message-ID: <001a01c72593$9c11c920$0b96a8c0@Thomas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1695241884=="
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

--===============1695241884==
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
Content-Transfer-Encoding: 7bit

hello everyone:
 i meet some trouble in configure the ALSA.
who can help me ? is there have some document for config?
Thanks!

Thomas

when i use the aplay test.wav.
the program shows:
ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:550: audio open error: No such file or directory

 $ lsmod
Module                  Size  Used by
snd_as352x_audio       10050  0
snd_ac97_codec         96172  1 snd_as352x_audio
snd_ac97_bus            2016  1 snd_ac97_codec


#
#  ALSA library configuration file
#

# pre-load the configuration files

@hooks [
 {
  func load
  files [
   "/etc/asound.conf"
   "~/.asoundrc"
  ]
  errors false
 }
]

.........
pcm.as352x {
type plug
slave  {
pcm {
    type hw
    card 0
    }
#format "S16_LE"
#channels 2
rate "unchanged"
}
}
Br
Thomas



--===============1695241884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1695241884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1695241884==--
