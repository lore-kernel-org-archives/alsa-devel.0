From: "vitton.laforest" <vitton.laforest@free.fr>
Subject: Re: SB Live! 24-Bit External: remote control support : more details
Date: Mon, 08 May 2006 19:17:58 +0200
Message-ID: <445F7D46.6010703@free.fr>
References: <44512925.30803@vardes.lv> <20060428084200.GA26640@turing.informatik.uni-halle.de> <4451E5C2.7050104@vardes.lv> <20060505075159.GA2171@turing.informatik.uni-halle.de> <pan.2006.05.07.23.29.22.651163@free.fr> <20060508071454.GC11272@turing.informatik.uni-halle.de> <445F052D.5020102@free.fr> <20060508114841.GA23340@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------040804030007030004050503"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060508114841.GA23340@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040804030007030004050503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dear all

1) The problem is fixed as i was loading the wrong snd-usb-audio (sorry) 
: the one coming with the kernel and not the one with the patch (sorry 
again). Now it works , thanks !!!

2) Then i had problems with lirc, as i have to define a new lircd.conf 
with my RM1500 remote control, the one delivered with lirc was not 
working. I did it using irrecord and at the moment defined only few buttons

I have attached the file for those who would be interested. It works 
with mplayer ( at least vol + and vol-) . I will complete and distribute 
it in few days.

3) the last problem i have is for recording with the live 24!! but i 
will post a new mail
best regards
JP


#
# this config file was automatically generated
# using lirc-0.6.6(serial) on Mon Jan 12 17:28:59 2004
#
# contributed by: Michael Plugge <firefox2501@hotmail.com>
#
# brand: Creative
# model no. of remote control: RM-1500
# devices being controlled by this remote: Audigy 2 NX
#
# This remote comes with the SoundBlaster Audigy 2 NX USB sound card. 
This file
# was created using a home brew serial receiver. I am not sure if the IR
# reciever that is built into the Audigy 2 NX will work.
#

# Please make this file available to others
# by sending it to <lirc@bartelmus.de>
#
# this config file was automatically generated
# using lirc-0.8.0(alsa_usb) on Mon May 8 18:38:35 2006
#
# contributed by
#
# brand: toto
# model no. of remote control:
# devices being controlled by this remote:
#

begin remote

name toto
bits 8
eps 30
aeps 100

one 0 0
zero 0 0
gap 315848
min_repeat 1
toggle_bit 0


begin codes
vol- 0x9C
vol+ 0x9D
mute 0x91
up 0x84
down 0x72
next 0x8A
prev 0x78
end codes

end remote




Clemens Ladisch a e'crit:

>(please don't top-post)
>
>vitton.laforest wrote:
>  
>
>>Clemens Ladisch a e'crit:
>>    
>>
>>>jpv wrote:
>>>      
>>>
>>>>Impossible to get the remote control working with my Live 24 external even
>>>>with the patch.
>>>>
>>>>No device corresponding to the remote control.
>>>>and nothing in /proc/asound/hwdep 
>>>>        
>>>>
>>>What are the contents of /proc/asound/cards?
>>>      
>>>
>> 0 [External       ]: USB-Audio - SB Live! 24-bit External
>>                      Creative Technology SB Live! 24-bit External at usb-0000:00:02.3-3, full speed
>> 1 [SI7012         ]: ICH - SiS SI7012
>>                      SiS SI7012 with CMI9738 at 0xdc00, irq 10
>> 2 [ALS4000        ]: ALS4000 - Avance Logic ALS4000
>>                      Avance Logic ALS4000 at 0xd400, irq 11
>>    
>>
>
>So the driver is loaded correctly.
>
>What is the output of lsusb?
>
>Did you unload and reload all sound modules after patching and
>recompiling the driver?
>
>
>Regards,
>Clemens
>
>
>  
>

--------------040804030007030004050503
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=us-ascii" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Dear all<br>
<br>
1) The problem is fixed as i was loading the wrong snd-usb-audio
(sorry) : the one coming with the kernel and not the one with the patch
(sorry again). Now it works , thanks !!!<br>
<br>
2) Then i had problems with lirc, as i have to define a new lircd.conf
with my RM1500 remote control, the one delivered with lirc was not
working. I did it using irrecord and at the moment defined only few
buttons <br>
<br>
I have attached the file for those who would be interested. It works
with mplayer ( at least vol + and vol-) . I will complete and
distribute it in few days.<br>
<br>
3) the last problem i have is for recording with the live 24!! but i
will post a new mail<br>
best regards<br>
JP<br>
<br>
<br>
#<br>
# this config file was automatically generated<br>
# using lirc-0.6.6(serial) on Mon Jan 12 17:28:59 2004<br>
#<br>
# contributed by: Michael Plugge <a class="moz-txt-link-rfc2396E" href="mailto:firefox2501@hotmail.com">&lt;firefox2501@hotmail.com&gt;</a><br>
#<br>
# brand:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Creative<br>
# model no. of remote control: RM-1500<br>
# devices being controlled by this remote: Audigy 2 NX<br>
#<br>
# This remote comes with the SoundBlaster Audigy 2 NX USB sound card.&nbsp;
This file<br>
# was created using a home brew serial receiver.&nbsp; I am not sure if the
IR <br>
# reciever that is built into the Audigy 2 NX will work.<br>
#<br>
<br>
# Please make this file available to others<br>
# by sending it to <a class="moz-txt-link-rfc2396E" href="mailto:lirc@bartelmus.de">&lt;lirc@bartelmus.de&gt;</a><br>
#<br>
# this config file was automatically generated<br>
# using lirc-0.8.0(alsa_usb) on Mon May&nbsp; 8 18:38:35 2006<br>
#<br>
# contributed by<br>
#<br>
# brand:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toto<br>
# model no. of remote control:<br>
# devices being controlled by this remote:<br>
#<br>
<br>
begin remote<br>
<br>
&nbsp; name&nbsp; toto<br>
&nbsp; bits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
&nbsp; eps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30<br>
&nbsp; aeps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100<br>
<br>
&nbsp; one&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp; zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp; gap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 315848<br>
&nbsp; min_repeat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&nbsp; toggle_bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; begin codes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vol-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vol+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x91<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x72<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x78<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end codes<br>
<br>
end remote<br>
<br>
<br>
<br>
<br>
Clemens Ladisch a &eacute;crit&nbsp;:
<blockquote
 cite="mid20060508114841.GA23340@turing.informatik.uni-halle.de"
 type="cite">
  <pre wrap="">(please don't top-post)

vitton.laforest wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Clemens Ladisch a e'crit:
    </pre>
    <blockquote type="cite">
      <pre wrap="">jpv wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">Impossible to get the remote control working with my Live 24 external even
with the patch.

No device corresponding to the remote control.
and nothing in /proc/asound/hwdep 
        </pre>
      </blockquote>
      <pre wrap="">What are the contents of /proc/asound/cards?
      </pre>
    </blockquote>
    <pre wrap=""> 0 [External       ]: USB-Audio - SB Live! 24-bit External
                      Creative Technology SB Live! 24-bit External at usb-0000:00:02.3-3, full speed
 1 [SI7012         ]: ICH - SiS SI7012
                      SiS SI7012 with CMI9738 at 0xdc00, irq 10
 2 [ALS4000        ]: ALS4000 - Avance Logic ALS4000
                      Avance Logic ALS4000 at 0xd400, irq 11
    </pre>
  </blockquote>
  <pre wrap=""><!---->
So the driver is loaded correctly.

What is the output of lsusb?

Did you unload and reload all sound modules after patching and
recompiling the driver?


Regards,
Clemens


  </pre>
</blockquote>
</body>
</html>

--------------040804030007030004050503--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
