From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp update
Date: Fri, 07 Nov 2003 13:55:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAB9627.2050700@undata.org>
References: <3FAA408F.50201@undata.org> <3FAB7F9D.6090606@ifrance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FAB7F9D.6090606@ifrance.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benouille <benouille@ifrance.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Benouille wrote :

> Hi list, hi thomas,
> 
> A big thank you for all your great job on the rme hdsp.
> I've installed the alsa cvs dated from the november 5th on 2 pc:
> one with a hdsp multiface, one with a hdsp 9652.
> 
> Since this update, I can't access anymore the level of the channels with
> amixer, and alsamixer reponds 'no mixer element found' on both system.
> Is it a normal behaviour?

It is. I removed those simple mixer controls because I could find no 
proper way to deal with them while changing speed mode.
Anyway, anything you could do with those you can do either with 
hdspmixer or amixer in console mode, using the 'Mixer' ctl.

The amixer syntax is as follows :

amixer -c X cset numid=5 in,out,level

Where:
X is your alsa card number
0  <= in  < 26  : physical inputs
26 <= in  < 52  : playbacks (software outputs)
0  <= out < 26  : physical outputs
26 <= out <= 27 : line outs (phones), if any
0  <= level < 65536 : gain (65535 = +6dB, 32768 = 0dB)

(H9632 users should read :
0  <= in  < 16 : physical inputs
16 <= in  < 32 : playbacks (softwre outputs)
0  <= out < 16 : physical outputs
)

Here's an example :
amixer cset numid=5 26,0,32768
amixer cset numid=5 27,1,32768
This routes software outputs 1/2 (playback_1 and playback_2 in jack) to 
physical outputs 1/2 with a 0dB gain.
It is the same as formerly setting the level to 50% in the first 2 
alsamixer strips.

Below is a small script that does the same as the first hdspmixer preset 
(for non-h9632 cards, and assumes the hdsp card is the default one) :

#! /bin/bash

for out_left in $(seq 0 2 25);
do
let out_right=$out_left+1
let in_left=$out_left+26
let in_right=$out_right+26
amixer cset numid=5 $in_left,$out_left,32768
amixer cset numid=5 $in_left,26,32768
amixer cset numid=5 $in_right,$out_right,32768
amixer cset numid=5 $in_right,27,32768;
done;

> 
> Then, when I boot, the hdsp multiface is still locked and I need to call
> 'hdsploader' about 3 or 5 times (I have the 'post-install snd-hdsp
> /usr/local/bin/hdsploader' in modules.conf)

I know this problem, but didn't find a solution yet. For some reason the 
specified wait time isn't always respected, so even if the firmware has 
been correctly uploaded ('host' light turns off on the io box), the 
function returns too early with an error, and the initialization process 
in stopped (the alsa pcm and midi devices are not created). Running 
hdsploader a second time usually fixes this.

> then, I have to reboot, and run hdspmixer to unmute the channels.
> I woul like to know if there is a way to start the system with the card
> properly running and all channels unmuted.
> Maybe you could show us your modules.conf?
> 

I have nothing special in my modules.conf, I usually run hdsploader by 
hand. You may use the above script to set the levels up.

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
