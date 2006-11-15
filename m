From: Jurij Smakov <jurij@wooyd.org>
Subject: Debugging microphone problem on snd-hda-intel (Dell
	M1210 laptop)
Date: Tue, 14 Nov 2006 20:16:48 -0800
Message-ID: <20061115041648.GA4252@droopy.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm part of the gang which has a bit of a problem with getting the 
microphone jack work on a Dell M1210 laptop, which is equipped with 
Intel HD Audio card (chip is identified SigmaTel STAC9221 A1 by 
alsamixer). I read and poked around a bit, and I think I figured out 
what the problem might be, however I need further advice on how to 
handle it.

Looking at the /proc/asound/card0/codec#0, I can see that this card 
has two ADCs (marked as [Audio Input]) at nids 0x06 and 0x07:

Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x18

Each of them have a single input, nids 0x17 and 0x18 respectively:

Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0e 0x0e]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x13

AFAICT, those are just pass-through amps, since each of them have only 
one input. Those inputs are 0x12 and 0x13, which are the audio 
selectors:

Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a

The microphone jack (pink one, the right-most out of three on the 
front) is 0x0c -- I figured it out by hacking up hda_proc.c to display 
the pin sense. No other nid has 0x0c as its input, so I guess that the 
only way to route the signal from microphone jack to the ADC is to use
one of the paths:

Pin(0x0c) -> Audio Selector(0x12) -> Audio Selector(0x17) -> Audio Input(0x06)
Pin(0x0c) -> Audio Selector(0x13) -> Audio Selector(0x18) -> Audio Input(0x07)

I tried routing the input from 0x0c to audio selectors 0x12 and 0x13 
(by hacking on patch_sigmatel.c). That worked, but I still didn't get 
any audible input from the mic. I am a bit at loss on where to go from 
here. I suspect that some of the amps in the chain may be 
disabled/muted, and alsamixer does not provide any controls for them 
(or something). I'd appreciate any advice, as the non-working mic is 
pretty much the only thing which keeps me unhappy about my new laptop 
:-). Just in case, I did try disable_msi=1 trick and different models, 
that did not make any difference. I would be willing to provide any 
other information or test patches, if need arises.

You can find the complete output of /proc/asound/card0/codec#0 at

http://www.wooyd.org/misc/codec.txt

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
