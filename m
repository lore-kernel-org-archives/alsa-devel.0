From: V Ganesh <ganesh@veritas.com>
Subject: Bit-exact 44.1KHz SPDIF on Via 8237 + AD1888
Date: Wed, 23 Nov 2005 10:22:49 +0530
Message-ID: <1132721569.26891.70.camel@janus.vxindia.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gold.veritas.com (gold.veritas.com [143.127.12.110])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA833191
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 05:47:29 +0100 (MET)
Received: from janus.vxindia.veritas.com([10.212.2.75]) (2987 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <ganesh@veritas.com>)
	id <m1EemXU-0001FfC@megami.veritas.com>
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 20:47:24 -0800 (PST)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
	I've been trying for several days to get a bit-exact 44.1KHz stream
from my motherboard to my receiver via SPDIF. The idea is to have ripped
CD tracks stored on hard disk and play them *without* resampling to
48KHz, letting the receiver DACs do the real work.

	The motherboard is an Asus K8V-MX with a VIA 8237 controller and an
AD1888 AC'97 codec. The driver used is snd-via82xx from alsa 1.0.10.
The main problem I was facing was that even after setting up the SPDIF
link to be 44.1KHz (and confirming from my receiver that it was indeed
getting a 44.1KHz PCM stream), the sound was Mickey-moused i.e. it
sounded like 44.1 being played at 48. 

I was using device=spdif, which in my case dumps it to device 0,
subdevice 3 (the DXS3 stream). It appears that this is a bad idea
because of the DXS in the controller, which seems to resample
*everything* to 48KHz in order to do its mixing, regardless of the
sample rate set on the codec's DACs or the SPDIF sample rate. Basically

                        AC-link                        coax
44.1 data--> VIA8237    -------> AD1888 --> SPDIF out -----> Receiver
(app data)   (DXS logic          (DACs set  (Set to 44.1)
              resamples           to 44.1 -
              to 48K)             irrelevant)

I tried various dxs_support options, all in vain.

The AD1888 codec, however, appears to support section 5.10.2.2
'Simultaneous DAC playback and S/PDIF transmission of "bit-exact" 32,
44.1 or 48KHz PCM streams' of the AC'97 2.3 spec (page 72), which is
exactly what I want. This calls for
     1. Slot 3/4 sample rates set to 44.1KHz
     2. SPSR set to 44.1KHz
     3. SPSA set to 0 i.e. slots 3/4 (these are usually set to 10/11)
This is easily achieved by fiddling around with the mixer
and/or /etc/alsa config files.

Now all you need to do is somehow bypass DXS and feed data directly to
the codec. Fortunately, this is as simple as using the multichannel PCM
device (device 0,1) instead of the default (device 0,0). And it works!

Conclusion:
If you want to play CD-rate music via SPDIF without resampling, don't
use the spdif device. If you want to pass-through ac3 or dts, then the
default spdif (device 0, subdevice 3) is probably the best option.

What are your thoughts are on changing the default PCM device to the
multichannel one, and inflicting DXS only on those who specifically ask
for it? I know it can be done in .asoundrc, but IMHO it's better to do
it in the package itself.

Thanks,
Ganesh



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
