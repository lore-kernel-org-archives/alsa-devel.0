From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [Jackit-devel] Multiple cards.
Date: Wed, 12 Jun 2002 21:03:22 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D07388A.3010202@boosthardware.com>
References: <Pine.LNX.3.96.1020609234513.20161B-100000@planck.clarku.edu> <E17HH98-0005Ai-00@usw-sf-list1.sourceforge.net> <20020610155238.E6051@ecs.soton.ac.uk> <3D06E569.6080305@boosthardware.com> <3D06F382.ED7BCC17@folkwang-hochschule.de> <3D070D18.4050505@boosthardware.com> <3D071681.D0F07B00@folkwang-hochschule.de>
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
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Joern Nettingsmeier wrote:
> Patrick Shirkey wrote:
> 
>>
>>In your example you don't say whether your cards have are stereo or mono
>>  channels.
>>
>>I get this ouput when starting jack
>>
>>----
>># jackd -R -v -d alsa -d ttable
>>jackd 0.33.0
>>Copyright 2001-2002 Paul Davis and others.
>>jackd comes with ABSOLUTELY NO WARRANTY
>>This is free software, and you are welcome to redistribute it
>>under certain conditions; see the file COPYING for details
>>
>>3475 waiting for signals
>>creating alsa driver ... ttable|1024|2|48000|swmon
>>ALSA: no playback configurations available
>>ALSA: cannot configure capture channel
>>cannot load driver module alsa
>>jack main caught signal 15
>>-----
>>
>>Using the following in my .asoundrc file. I'm not sure if it is correct
>>as card0 has two stereo pcm devices. I'm not sure whether they are being
>>defined in the following or not.
>>
>>Does
>>
>>         slaves.a.channels 2
>>
>>refer to the pcm devices
>>
>>         eg. hw:0,0 and hw:0,1
>>
>>or the first two mono channels available on card0?
>>
>>         eg. left and right channels on hw:0,0
> 
> 
> don't know.
> just try slaves.a.pcm "hw:0,0"; slaves.a.channels 4;
> or alternatively channels 2 and slave.b.pcm "hw:0,1"; slave.b.channels
> 2;
> and see what happens.
> 

nope it is for the pcm devices based on that test.

> also try arecord|aplay to see if the multi device is doing what you
> think it does.
> 
> i must confess i have no clear idea what devices and subdevices (the
> second and optionally third digit after the card number) really are on a
> hardware level. perhaps you should take this thread over to alsa-dev ?
> 

It seems they represent the place which the binding points to for each 
channel.

So     "ttable     0.0     1"     means

"make    binding 0 from fake card "multi".point to channel 0    on this 
fake pcm device"

After exploring this through the afternoon I have come to think that it 
is not exactly what I would like.

IIUC using this in .asoundrc will allow me to make a fake multichannel 
card that uses multiple devices from different cards. Fooling JACK into 
thinking that it is accessing one card instead of many.

This allows me to have multiple outputs available inside the ardour 
connections gui for example.

It seems unecessary to have to set this up though because the devices 
are already available to be accessed as hw:0,0 hw:0,1 hw:1,0 ...

Shouldn't JACK find all available inputs and outputs by default instead 
of relying on the user to define the device to be used?

If not it seems that JACK is missing an extremely lucrative feature 
which would contribute greatly to Linux audio and would no doubt peak 
the interest of anyone who is not already interested.

I can hear Paul now saying you have no desire to make this happen 
because you do not work with consumer devices. Unless someone paid you 
to do it.

I have two questions.

If it is possible to do and the code was written would it be included in 
JACK?

If it is possible to do how much would it cost to have it implemented?


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
