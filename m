From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Thu, 13 Jun 2002 02:31:12 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D078560.4030707@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>	<3D06D91D.1080104@boosthardware.com>	<s5hhek81vgl.wl@alsa2.suse.de>	<3D07564B.4050908@boosthardware.com>	<s5hbsag1t5r.wl@alsa2.suse.de>	<3D0760FC.5060906@boosthardware.com>	<3D0772F1.6090009@boosthardware.com>	<3D077B61.7030902@boosthardware.com> <s5hzny0zb43.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 13 Jun 2002 01:48:33 +0900,
> Patrick Shirkey wrote:
> 
>>Patrick Shirkey wrote:
>>
>>>Patrick Shirkey wrote:
>>>
>>>
>>>>i have been testing the sound and I am getting playback although at 
>>>>this point I can get sound out of hw:2,0 and hw:2,2 they are both the 
>>>>left channels. The sound is scratchy but it is there :)
>>>>
>>>
>>>The sound is actually coming through output 2 and 4 on the sound card 
>>>even though I'm using hw:2,0 or hw:2,2.
>>>
>>
>>When I use the first two pcm devices the sound is sent through output 2 
>>on the card and when I use the third the sound is sent through output 4.
> 
> 
> i committed a minor change to cvs.
> now endpoints will be shown in each proc file.
> could you apply and send me the output of each proc file?
> i'd like to know whether really endpoints are parsed correctly.
> 
> 

 From the looks of things they are not.

------
# cat /proc/asound/card2/stream0
M Audio USB AudioSport Quattro (tm) : USB Audio

Playback:
   Format: S16_LE
   Channels: 2
   Endpoint: 3 OUT
   Rates: 11025, 22050, 44100

Capture:
   Format: S16_LE
   Channels: 2
   Endpoint: 5 IN
   Rates: 11025, 22050, 44100

# cat /proc/asound/card2/stream1
M Audio USB AudioSport Quattro (tm) : USB Audio #1

Playback:
   Format: S16_LE
   Channels: 2
   Endpoint: 3 OUT
   Rates: 11025, 22050, 44100, 48000

Capture:
   Format: S16_LE
   Channels: 2
   Endpoint: 5 IN
   Rates: 11025, 22050, 44100, 48000

# cat /proc/asound/card2/stream2
M Audio USB AudioSport Quattro (tm) : USB Audio #2

Playback:
   Format: S16_LE
   Channels: 2
   Endpoint: 4 OUT
   Rates: 11025, 22050, 44100, 48000

Capture:
   Format: S16_LE
   Channels: 2
   Endpoint: 6 IN
   Rates: 11025, 22050, 44100, 48000

------



> 
>>I have also tested capture and the card is not working with that yet.
>>
>>It will attempt to record for a few seconds but will not write to a file 
>>or produce any noise either with direct monitoring enabled or not. Also 
>>  recording locks the mouse until either it has finished or is ctrl+c'd.
> 
> 
> hmm, this sounds bad.
> i'm not sure whether this is a general capture problem on usb audio.
> i'll borrow a usb mic tomorrow and test with it.
> 
> 
> ciao,
> 
> Takashi
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
