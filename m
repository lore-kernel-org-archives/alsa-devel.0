From: Vincent Vanackere <vanackere@cmi.univ-mrs.fr>
Subject: GUS driver status : multiple open of /dev/dsp ?
Date: Thu, 06 Jun 2002 11:29:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CFF2B90.6050304@cmi.univ-mrs.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Cc: Vincent Vanackere <vanackere@gyptis.univ-mrs.fr>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm sorry to ask such a common question here, but I'd like to know if
it is possible to configure my (old) Gravis Ultrasound ISA PnP card in 
order to enable multiple open of /dev/dsp with alsa.
  I know for sure that this card is able to perform hardware mixing: the 
windows drivers I'm using just do it. I've seen numerous posts on that 
subject in the mailing-list archive, but couldn't find any real answer:

1) Is it supported by alsa (yet) ?

2) If so, how can I enable it ? Do I have to play tricks with my 
.asoundrc ? Should I try another driver (gusclassic/gusmax/gusextreme)
instead of interwave ?

Thanks by advance for any answer,

Vincent


P.S.: my current drivers:

---------------------------------

diablo:~$ cat /proc/asound/pcm
00-00: CS4231 : AMD InterWave rev B (chip) : playback 1 : capture 1
00-01: AMD InterWave : AMD InterWave rev B (synth) : playback 1

diablo:~$ cat /proc/asound/cards
0 [card0          ]: AMD InterWave - AMD InterWave
                      AMD InterWave at 0x220, irq 5, dma 3&1

diablo:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.0rc1.
Compiled on May 31 2002 for kernel 2.4.19-pre9.


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
