From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa hw params on SB Pro
Date: Mon, 14 Feb 2005 10:43:47 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502141038070.20014-200000@studcom.urz.uni-halle.de>
References: <20050208053606.GB8616@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2015913978-758783491-1108374021=:20014"
In-Reply-To: <20050208053606.GB8616@dbz.icequake.net>
Content-ID: <Pine.HPX.4.33n.0502141041510.21230@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2015913978-758783491-1108374021=:20014
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.HPX.4.33n.0502141041511.21230@studcom.urz.uni-halle.de>

Ryan Underwood wrote:
> I seem to have the following problem.  On snd-sb8 with a SBPro (which is
> capable of stereo), the best stereo playback mode is 22KHz - going above
> 22KHz implies that the output will be only one channel.
>
> If I call snd_pcm_hw_params_set_channels_near with argument of 2
> channels, I get 2 channels as requested.  But then I call
> snd_pcm_hw_params_set_rate_near with argument of 44100, and have 44100
> returned.  Thus I end up with a hwparams that the hardware is not
> capable of.

Seems to work with the attached test program:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Pro [Sound Blaster Pro], device 0: SB8 DSP [DSP v3.2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ sbhwp

channels: 1-2, rate: 4000-43479
set channels to 2
channels: 2-2, rate: 10989-22223

channels: 1-2, rate: 4000-43479
set rate to 44100
channels: 1-1, rate: 43478-43479


Probably you've been using some device using the plug plugin.


Best regards,
Clemens

--2015913978-758783491-1108374021=:20014
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="sbhwp.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.HPX.4.33n.0502141040210.20014@studcom.urz.uni-halle.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="sbhwp.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5j

bHVkZSA8YWxzYS9hc291bmRsaWIuaD4NCg0Kc25kX3BjbV90ICpwY207DQpz

bmRfcGNtX2h3X3BhcmFtc190ICpod19wYXJhbXM7DQoNCiNkZWZpbmUgQ0hF

Q0soZm4pIGNoZWNrKGZuLCAjZm4pDQoNCnZvaWQgY2hlY2soaW50IGVyciwg

Y29uc3QgY2hhciAqZm4pDQp7DQoJaWYgKGVyciA8IDApIHsNCgkJZnByaW50

ZihzdGRlcnIsICIlcyBmYWlsZWQ6ICVzXG4iLCBmbiwgc25kX3N0cmVycm9y

KGVycikpOw0KCQlleGl0KEVYSVRfRkFJTFVSRSk7DQoJfQ0KfQ0KDQp2b2lk

IHByaW50KHZvaWQpDQp7DQoJdW5zaWduZWQgaW50IGNtaW4sIGNtYXg7DQoJ

dW5zaWduZWQgaW50IHJtaW4sIHJtYXg7DQoJQ0hFQ0soc25kX3BjbV9od19w

YXJhbXNfZ2V0X2NoYW5uZWxzX21pbihod19wYXJhbXMsICZjbWluKSk7DQoJ

Q0hFQ0soc25kX3BjbV9od19wYXJhbXNfZ2V0X2NoYW5uZWxzX21heChod19w

YXJhbXMsICZjbWF4KSk7DQoJQ0hFQ0soc25kX3BjbV9od19wYXJhbXNfZ2V0

X3JhdGVfbWluKGh3X3BhcmFtcywgJnJtaW4sIE5VTEwpKTsNCglDSEVDSyhz

bmRfcGNtX2h3X3BhcmFtc19nZXRfcmF0ZV9tYXgoaHdfcGFyYW1zLCAmcm1h

eCwgTlVMTCkpOw0KCXByaW50ZigiY2hhbm5lbHM6ICV1LSV1LCByYXRlOiAl

dS0ldVxuIiwgY21pbiwgY21heCwgcm1pbiwgcm1heCk7DQp9DQoNCnZvaWQg

aW5pdCh2b2lkKQ0Kew0KCUNIRUNLKHNuZF9wY21faHdfcGFyYW1zX2FueShw

Y20sIGh3X3BhcmFtcykpOw0KCUNIRUNLKHNuZF9wY21faHdfcGFyYW1zX3Nl

dF9hY2Nlc3MocGNtLCBod19wYXJhbXMsIFNORF9QQ01fQUNDRVNTX1JXX0lO

VEVSTEVBVkVEKSk7DQoJQ0hFQ0soc25kX3BjbV9od19wYXJhbXNfc2V0X2Zv

cm1hdChwY20sIGh3X3BhcmFtcywgU05EX1BDTV9GT1JNQVRfVTgpKTsNCglw

dXRzKCIiKTsNCglwcmludCgpOw0KfQ0KDQppbnQgbWFpbigpDQp7DQoJdW5z

aWduZWQgaW50IGMgPSAyLCByID0gNDQxMDA7DQoNCglDSEVDSyhzbmRfcGNt

X2h3X3BhcmFtc19tYWxsb2MoJmh3X3BhcmFtcykpOw0KCUNIRUNLKHNuZF9w

Y21fb3BlbigmcGNtLCAiaHc6MCIsIFNORF9QQ01fU1RSRUFNX1BMQVlCQUNL

LCAwKSk7DQoNCglpbml0KCk7DQoJcHJpbnRmKCJzZXQgY2hhbm5lbHMgdG8g

JXVcbiIsIGMpOw0KCUNIRUNLKHNuZF9wY21faHdfcGFyYW1zX3NldF9jaGFu

bmVsc19uZWFyKHBjbSwgaHdfcGFyYW1zLCAmYykpOw0KCXByaW50KCk7DQoN

Cglpbml0KCk7DQoJcHJpbnRmKCJzZXQgcmF0ZSB0byAldVxuIiwgcik7DQoJ

Q0hFQ0soc25kX3BjbV9od19wYXJhbXNfc2V0X3JhdGVfbmVhcihwY20sIGh3

X3BhcmFtcywgJnIsIE5VTEwpKTsNCglwcmludCgpOw0KDQoJQ0hFQ0soc25k

X3BjbV9jbG9zZShwY20pKTsNCglyZXR1cm4gMDsNCn0NCg==
--2015913978-758783491-1108374021=:20014--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
