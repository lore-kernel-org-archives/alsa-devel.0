From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [RFC] Dual Interface Codecs
Date: Wed, 03 Jan 2007 19:47:38 +0000
Message-ID: <1167853658.26687.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Seth Forshee <seth.forshee@gmail.com>
List-Id: alsa-devel@alsa-project.org

I'd like to gather some opinion on the best way to expose dual interface
codecs to alsa-lib and userspace in general.

Consider a codec with 2 digital audio interfaces :-

 1. I2S interface to host CPU
 2. PCM interface to BT codec or GSM modem.

Interface 1 is used for traditional playback and record. Interface 2 is
used to send and receive PCM audio to a BT codec (for Tx/Rx) from/to an
onboard Mic/Speaker.  e.g.

               ____________       DAI 2        ______
Mic --------> |   Codec    | <==============> |  BT  | --<
Spk <---------|____________|                  |______|
                    /\
                    ||  DAI 1
                    ||
                ____\/____
               |   CPU    |
               |__________|


This allows BT/GSM audio to work without the CPU DMAing any pcm data as
audio is now sent directly via the audio codec (the CPU can then sleep).

Currently, we have both interfaces exposed to userspace as PCM's. This
allows for hw params to be configured for interface 2 (as they would for
any other device). The only difference is that we never start the PCM
and always keep it in the prepared state.

There is the obvious problem that applications may try and start this
pcm, so I'm wondering if we need a new class of pcm device that doesn't
support a host buffer (e.g. bufferless) and cant be started ? or
alternatively some other approach may be better.

Cheers

Liam 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
