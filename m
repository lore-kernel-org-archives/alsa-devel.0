From: Rodrigo Severo <rodrigo.lists@fabricadeideias.com>
Subject: Re: BT878 support.
Date: Wed, 12 May 2004 15:22:46 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A26B76.4000200@fabricadeideias.com>
References: <Pine.HPX.4.33n.0405121732090.26780-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405121732090.26780-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>Rodrigo Severo wrote:
>
>  
>
>>Clemens Ladisch wrote:
>>
>>    
>>
>>>Rodrigo Severo wrote:
>>>
>>>      
>>>
>>>>I have two Prolink PlayTV Pro capture cards (PV-BT878P+). One of the=
m is
>>>>revision 8E and tthe other is revision 9F.
>>>>
>>>>I tried to use both of them with the snd-bt87x driver. Both of them
>>>>returned only static.
>>>>        
>>>>
>
>Did you try analog or digital or both?
>  
>
Both.

>  
>
>>>>I managed to get analog sound from the 8E with the btaudio (OSS) dri=
ver,
>>>>        
>>>>
>
>Does digital work?
>  
>
No. I get only silence from the digital device.

>  
>
>>>Which version?
>>>
>>>      
>>>
>>ALSA 1.0.4 and btaudio which came with kernel 2.4.25.
>>    
>>
>
>In theory, btaudio and snd-bt87x should behave identically.
>  
>
I thought so.

>What btaudio mixer settings and input do you use when it works?
>  
>
The default setting, i.e. the ones set when the driver is modprobed,  
work just fine.

Yesterday I was doing some extra tests. With aumixer I get three 
connections under btaudio: Line[1-3].

The audio capture works just the same no matter which device I set as 
the record device. The volume control affects the recording though (I 
have to leave the volume level really low not to get any noticeable 
distortion).

BTW, I have tested two other boards: a very old board autodetected by 
bttv as "(Askey Magic/others) TView99 CPH05 x [card=3D24], PCI subsystem=
 
ID is 144f:3002" and another Prolink PlayTV Pro, this time revision 9D.

With the Askey Magic I got only silence but with the Prolink PlayTV Pro 
revision 9D I got bad sound with btaudio. By bad I mean a slightly high 
pitch soundI got the sound of the TV with a slightly higher pitch than 
usual and with more than usual noise during silence. The sound was bad 
but at least I got something.

Today I found another BT878 board for sell here in Brasilia: Pinnacle 
PCTV. I could have tested it also but I got lazy. The store I found all 
these boards are a little distant from my work and I have already tested=
 
5 different boards.

Do you think there is any chance for these boards to work with btaudio 
and/or snd-bt87x?

BTW, is there some kind of list with boards that work with btaudio 
and/or snd-bt87x?



Thanks again for your attention,

Rodrigo Severo


-- 
----------------------------------------------------
Rodrigo Severo
F=E1brica de Id=E9ias
Fone: +55(61)321 1357
Fax: +55(61)223 1712
SBS - Quadra 2 - Ed. Empire Center - Sala 1301
Bras=EDlia/DF - Brasil
CEP: 70.070-904
----------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
