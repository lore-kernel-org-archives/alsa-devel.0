From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP + multiface "freezing" patch
Date: Fri, 07 Mar 2003 09:28:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18rImA-0005Lc-00@sc8-sf-list1.sourceforge.net>
References: <1047046715.3003.27.camel@lotte>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "07 Mar 2003 14:18:30 GMT."
             <1047046715.3003.27.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> >ok, I am trying to test Paul's patch on the HDSP9652, but I cant get it
>> >to play anything. I applied it to 0.9.0rc8b, but aplay just returns
>> 
>> which PCM device are you using?
>
>plughw:0,0
>
>(hw:0,0 gives the same error though. It should play 26 channels shouldnt
>it)

works here with the current HDSP driver but older ALSA CVS:
----------------------------------------------------------------------
paul[21]>cat /proc/asound/cards
0 [card0          ]: TRID4DWAVENX - Trident TRID4DWAVENX
                     Trident TRID4DWAVENX PCI Audio at 0xe400, irq 10
1 [card1          ]: RME9652 - RME Digi9652 (Rev 1.5)
                     RME Digi9652 (Rev 1.5) at 0xfd000000, irq 11
2 [hdsp           ]: H-DSP - Hammerfall DSP
                     RME Hammerfall DSP + Digiface at 0xfebe0000, irq 14
paul[22]>sync 
paul[23]>sync
paul[24]>sync
paul[25]>aplay -D plughw:1 /usr/local/music/cdstage/corner.wav 
Playing WAVE '/usr/local/music/cdstage/corner.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Aborted by signal Interrupt...
paul[26]>aplay -D plughw:2 /usr/local/music/cdstage/corner.wav  
Playing WAVE '/usr/local/music/cdstage/corner.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Aborted by signal Interrupt...














-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
