From: christopher cuse <ccuse@tiscali.fr>
Subject: amixer contents
Date: 29 Apr 2003 20:44:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1051641882.2101.8.camel@drs0.manchotnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

hi all,

i have a dell 2650 connected to a soundblaster extigy. everything
compiles, and alsaound service successfully loads the required modules.

[root@drs0 alsa]# amixer contents
<snip>
numid=3,iface=MIXER,name='Digital In Playback Source'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'PCM'
  ; Item #1 'Input 1'
amixer: Control default element read error: Invalid argument

numid=23,iface=MIXER,name='Digital In Playback Source',index=1
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'Mixer'
  ; Item #1 'PCM'
amixer: Control default element read error: Invalid argument


the errors affect the overall installation and i am unable to hear
sound.

would any of you be so kind as to suggest what i might try?

many thanks

christopher cuse



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
