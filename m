From: christopher cuse <ccuse@tiscali.fr>
Subject: alsa 0.9.3
Date: 07 May 2003 10:27:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052296068.2087.6.camel@drs0.manchotnetworks.net>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: alsa-user-list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I have an up2date red hat 8.0 install with external usb audio device
(extigy). I compiled, installed, and loaded modules without error,
however, the following issues are present:

[root@drs0 alsa]# alsactl store
alsactl: get_control:194: Cannot read control '2,0,0,Digital In Playback
Source,0': Invalid argument


[root@drs0 alsa]# play /usr/share/sounds/phone.wav
sox: Unable to sync dsp

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
<snip>

Any ideas, comments, suggestions are *greatly* appreciated!

Cheers

Christopher CUSE




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
