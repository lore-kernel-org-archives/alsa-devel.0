From: Dennis van der Meer <dvdmeer@wanadoo.nl>
Subject: Re: Terratec Aureon Space
Date: Wed, 04 Jun 2003 19:56:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030604194558.016464c0@192.168.10.1>
References: <5.1.0.14.2.20030603193926.01638eb0@192.168.10.1>
 <5.1.0.14.2.20030529001556.01651020@192.168.10.1>
 <s5h65nnnrnx.wl@alsa2.suse.de>
 <5.1.0.14.2.20030603193926.01638eb0@192.168.10.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7c2m4h8.wl@alsa2.suse.de>
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

>meanwhile, i committed the latest patchset to cvs now.
>i got reports that it works somehow.  so, please try the cvs version
>instead of my last patch.

A big thanks for the patchset. I was able to play sound with xmms
(not with the alsa-plugin but the OSS plugin worked). I am unable
to use the digital out to play sound though.
I have tried alsamixer but it will give me a lot of controls but not much
to work with. Somehow it's not working as it should.
Here's what I got from alsamixer:

Card: Terratec Aureon 7.1-Space
Chip: ICE1724 - multitrack

Name                    Item
-------------------------
Master  -->     Master
IEC958  -->     IEC958  (just the text IEC958 I)
                         PCM Out, H/W In 0, H/W In 1, IEC958 I
IEC958 O        -->     IEC958 Output
                         Volume bar cannot be adjusted
IEC958 1        -->     IEC958 1
                         PCM Out0, H/W In 0, H/W In 1, IEC958 I
Capture         -->     Capture
                         CD Left, CD Right, Aux Left, Aux Right, line Left, 
Line Right
ADC             -->     ADC
ADC 1           -->     ADC 1
DAC             -->     DAC
DAC 1           -->     DAC 1
DAC 2           -->     DAC 2
DAC 3           -->     DAC 3
DAC 4           -->     DAC 4
DAC 5           -->     DAC 5
DAC 6           -->     DAC 6
DAC 7           -->     DAC 7
H/W             --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
                     (changing values will set it to left channel only)
H/W 1           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
                     (changing values will set it to right channel only)
H/W 2           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
H/W 3           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
H/W 4           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
H/W 5           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
H/W 6           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
H/W 7           --> PCM Out0, H/W In 0, H/W In 1, IEC958 I
Multi Tr        --> Multi Track Internal Clock
                     44100
Multi Tr        --> Multi Track Peak (changed to strange values when 
started again)
Multi Tr        --> Multi Track Peak (changed to strange values when 
started again)
Multi Tr        --> Multi Track Peak (is restarted when app is started again)
Multi Tr        --> Multi Track Peak (is restarted when app is started again)
Multi Tr        --> Multi Track Rate Locking
Multi Tr        --> Multi Track Rate Reset

Some noticeable things:
         When I try some of the multi Track Peak controls and change the 
value they are
         reset or one of them is even set to random values

         Some controls have multiple values like PCM Out0, H/W In 0, H/W In 
1 and IEC958 I but
         I don't hear anything special or notice anything weird

         The H/W and H/W 1 seem to control the left channel and the right 
channel. Although
         this is not clear from the alsamixer app I can definately tell 
when I'm changing values

         IEC958 O has a volume bar but it cannot be adjusted

I also tried envy24control but this app keeps telling me that it doesn't 
know the card type ICE1724.
I am rather new to alsa so I'm assuming I did something wrong.

Should the digital in / out also be working and if so, how can I change the 
settings to set
it to digital out then?


Thanks,

Dennis van der Meer



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
