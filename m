From: Andrea Venturi <a.venturi@avalpa.com>
Subject: SOLVED: Re: Dell Studio 15 - aka Inspiron 1535 sound
 problems: HDA intel and codec IDT (STAC) 92HD73C1X5
Date: Wed, 06 Aug 2008 10:20:31 +0200
Message-ID: <48995ECF.2040607@avalpa.com>
References: <48987087.4040001@avalpa.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050804090005090505010209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.aruba.it (smtpd4.aruba.it [62.149.128.209])
	by alsa0.perex.cz (Postfix) with SMTP id 6EA3D2475C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 10:20:57 +0200 (CEST)
In-Reply-To: <48987087.4040001@avalpa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050804090005090505010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Venturi wrote:
> hi, i own a brand new Dell laptop Studio 15
>
> the audio speakers stay mute if i play an audio file. :-|
>
> i'm using debian lenny kernel.
>
> it seems to me a wrong port mapping. i put in place a newer Alsa 1.0.17
> kernel modules with debug enabled, but still no sound.

sorry for the noise on the ML.. i hate to seem so "clueless"!

now it works (more or less).

it was just a matter of toggling some alsamixer switches.

BTW the labels meaning in alsamixer seem not to fit too well, maybe 
because this HDA/codec couple are way too flexible and dynamically 
reconfigurable.. (and the alsa driver can't still cope so well)

With standard 1.0.17 driver, with regard to mixer status, internal 
speakers (IS) and headphones (HP), this is what i can say (various test) 
from left to right in Alsamixer:

    * there's both music on HP and IS
    * Master slider control both (IS & HP) Audio Levels
    * Headphone slider control just HP level
    * Headphone Mute toggle mute BOTH IS & HP when OFF (!)
    * PCM slider control level for both HP & IS (during mp3 player)
    * Front slider control level just for IS!
    * Analog Loopback toogle controls the IS (works when OFF!)
    * Analog Loopback 2 toogle controls the HP (works when OFF!)
    * the only HP jack working (there are two in this Dell Studio) is
      the middle one!
    * the other HP jack near the front of the laptop (HP2) doesn't work
    * if i plug a HP in the HP2 jack the IS quit the audio playing (if i
      unplug, the IS restart)
    * Analog Loopback 1 toggle doesn't do nothing at all (neither for
      IS, nor for HP and HP2)

So much is still to be checked and worked on, like:

   1. works with the original debian kernel alsa driver? don't know. i
      zapped that stuff during alsa ugrade so don't have the time to
      come back. maybe some one can tell us.
   2. are the Mics (internal near webcam and Jack) working? it's easy to
      test, some day, when i'll try Skyp! :-)
   3. why the second HP (HP2) doesn't work? need to investigate
   4. can we (should we) have auto mute for IS when HP is inserted?
      maybe it can be done at an user preference level!
   5. can we have digital output (SPDIF?) from one of the HP ports?
      (nice to have!)


i made some upgrade on this page, with some stuff also about the "other 
Os driver", could be helpful get some help from their .ini file:

http://www.avalpa.com/assets/andrea/studio15/debian_on_dell_studio15.html

that's all for now. i'm quite happier, now

sorry again for the noise.

bye

andrea venturi


--------------050804090005090505010209
Content-Type: text/x-vcard; charset=utf-8;
 name="a_venturi.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="a_venturi.vcf"

begin:vcard
fn:Andrea Venturi
n:;Andrea Venturi
org:Avalpa Digital Engineering SRL
adr;dom:;;Via dell'Arcoveggio 49/5;Bologna;BO;40129
email;internet:a.venturi@avalpa.com
title:CEO
tel;work:+39 0514187531
tel;cell:+39 3477142994
url:www.avalpa.com
version:2.1
end:vcard


--------------050804090005090505010209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050804090005090505010209--
