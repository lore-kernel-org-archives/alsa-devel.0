From: Mark Hills <mark@pogo.org.uk>
Subject: Buffer size/periods (Layla3G)
Date: Sun, 16 Mar 2008 12:02:58 +0000 (GMT)
Message-ID: <alpine.BSO.1.00.0803161126500.28063@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-459525358-1205668740=:28063"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 512052469E
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 13:03:01 +0100 (CET)
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>) id 1JarZq-0003Cj-HB
	for alsa-devel@alsa-project.org; Sun, 16 Mar 2008 12:02:58 +0000
Content-ID: <alpine.BSO.1.00.0803161159040.28063@metheny.ijneb.com>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-459525358-1205668740=:28063
Content-Type: TEXT/PLAIN; FORMAT=flowed; CHARSET=US-ASCII
Content-ID: <alpine.BSO.1.00.0803161159041.28063@metheny.ijneb.com>

Hello,

I am investigating problems I'm having with recording over long periods. 
I'm using a Layla3G and tested various ALSA versions including 1.0.14 and 
1.0.16 on different machines.

I've noticed that when I open the first pair of subdevices, my request for 
1000ms buffer size is handled differently to other devices:

   $ ./test_buffers "hw:Layla3G,0,0" 1000
   buffer_size=16384 period_size=128

   $ ./test_buffers "hw:Layla3G,0,2" 1000
   buffer_size=32768 period_size=256

   $ ./test_buffers "hw:Layla3G,0,4" 1000
   buffer_size=32768 period_size=256

   $ ./test_buffers "hw:Layla3G,0,6" 1000
   buffer_size=32768 period_size=256

If I try other buffer sizes, I can see is a limit to buffer size of 16384 
samples on the ,0 subdevice, which is also affecting the chosen period 
size. But only on the first subdevice. Is there a reason, or is this a 
bug?

Also, there seem to be failures at certain buffer sizes:

   $ ./test_buffers "hw:Layla3G,0,2" 429
   buffer_size=18912 period_size=96

   $ ./test_buffers "hw:Layla3G,0,2" 430
   set_buffer_time_near: Invalid argument

   $ ./test_buffers "hw:Layla3G,0,2" 431
   buffer_size=19008 period_size=96

Can anyone explain to me what's going on here, or is this also a bug?

The overall problem I'm investigating is snd_pcm_readi() returning 
incomplete buffers after running for long periods until another 
snd_pcm_prepare(). It seems possible that this is related.

Any help is greatly appreciated.

Thanks,

Mark
--0-459525358-1205668740=:28063
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=test_buffers.c
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.1.00.0803161159000.28063@metheny.ijneb.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=test_buffers.c

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8YWxzYS9hc291bmRsaWIu
aD4NCg0KI2RlZmluZSBSQVRFIDQ0MTAwDQojZGVmaW5lIENIQU5ORUxTIDIN
Cg0KI2RlZmluZSBDSEsobXNnLCByKSBcDQp7IFwNCglpZiAoKHIpIDwgMCkg
eyBcDQoJCWZwcmludGYoc3RkZXJyLCAiJXM6ICVzXG4iLCBtc2csIHNuZF9z
dHJlcnJvcihyKSk7IFwNCgkJcmV0dXJuIC0xOyBcDQoJfSBcDQp9DQoNCmlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQp7DQoJaW50IHIsIGRp
cjsNCgl1bnNpZ25lZCBpbnQgcDsNCglzbmRfcGNtX3QgKnBjbTsNCglzbmRf
cGNtX2h3X3BhcmFtc190ICpod19wYXJhbXM7DQoJc25kX3BjbV91ZnJhbWVz
X3QgYnVmZmVyX3NpemUsIHBlcmlvZF9zaXplOw0KDQoJciA9IHNuZF9wY21f
b3BlbigmcGNtLCBhcmd2WzFdLCBTTkRfUENNX1NUUkVBTV9DQVBUVVJFLCAw
KTsNCglDSEsoIm9wZW4iLCByKTsNCg0KCXIgPSBzbmRfcGNtX2h3X3BhcmFt
c19tYWxsb2MoJmh3X3BhcmFtcyk7DQoJQ0hLKCJwYXJhbXNfbWFsbG9jIiwg
cik7DQoNCglyID0gc25kX3BjbV9od19wYXJhbXNfYW55KHBjbSwgaHdfcGFy
YW1zKTsNCglDSEsoInBhcmFtc19hbnkiLCByKTsNCg0KCXIgPSBzbmRfcGNt
X2h3X3BhcmFtc19zZXRfYWNjZXNzKHBjbSwgaHdfcGFyYW1zLA0KCQkJCQkg
U05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFWRUQpOw0KCUNISygicGFyYW1z
X3NldF9hY2Nlc3MiLCByKTsNCg0KCXIgPSBzbmRfcGNtX2h3X3BhcmFtc19z
ZXRfZm9ybWF0KHBjbSwgaHdfcGFyYW1zLCBTTkRfUENNX0ZPUk1BVF9TMzIp
Ow0KCUNISygic2V0X2Zvcm1hdCIsIHIpOw0KDQoJciA9IHNuZF9wY21faHdf
cGFyYW1zX3NldF9yYXRlKHBjbSwgaHdfcGFyYW1zLCBSQVRFLCAwKTsNCglD
SEsoInNldF9yYXRlIiwgcik7DQoNCglyID0gc25kX3BjbV9od19wYXJhbXNf
c2V0X2NoYW5uZWxzKHBjbSwgaHdfcGFyYW1zLCBDSEFOTkVMUyk7DQoJQ0hL
KCJzZXRfY2hhbm5lbHMiLHIpOw0KDQoJaWYgKGFyZ2MgPiAyKSB7DQoJICAg
ICAgICBwID0gYXRvaShhcmd2WzJdKSAqIDEwMDA7DQoJCXIgPSBzbmRfcGNt
X2h3X3BhcmFtc19zZXRfYnVmZmVyX3RpbWVfbmVhcihwY20sIGh3X3BhcmFt
cywNCgkJCQkJCQkgICAmcCwgJmRpcik7DQoJCUNISygic2V0X2J1ZmZlcl90
aW1lX25lYXIiLCByKTsNCgl9DQoNCglpZiAoYXJnYyA+IDMpIHsNCgkJcCA9
IGF0b2koYXJndlszXSkgKiAxMDAwOw0KCQlyID0gc25kX3BjbV9od19wYXJh
bXNfc2V0X3BlcmlvZF90aW1lX25lYXIocGNtLCBod19wYXJhbXMsDQoJCQkJ
CQkJICAgJnAsICZkaXIpOw0KCQlDSEsoInNldF9wZXJpb2RfdGltZV9uZWFy
Iiwgcik7DQoJfQ0KDQoJciA9IHNuZF9wY21faHdfcGFyYW1zKHBjbSwgaHdf
cGFyYW1zKTsNCglDSEsoImh3X3BhcmFtcyIsIHIpOw0KDQoJciA9IHNuZF9w
Y21faHdfcGFyYW1zX2dldF9idWZmZXJfc2l6ZShod19wYXJhbXMsICZidWZm
ZXJfc2l6ZSk7DQoJQ0hLKCJnZXRfYnVmZmVyX3NpemUiLCByKTsNCg0KCXIg
PSBzbmRfcGNtX2h3X3BhcmFtc19nZXRfcGVyaW9kX3NpemUoaHdfcGFyYW1z
LCAmcGVyaW9kX3NpemUsICZkaXIpOw0KCUNISygiZ2V0X3BlcmlvZF9zaXpl
Iiwgcik7DQoNCglwcmludGYoImJ1ZmZlcl9zaXplPSVkIHBlcmlvZF9zaXpl
PSVkXG4iLA0KCSAgICAgICAoaW50KWJ1ZmZlcl9zaXplLCAoaW50KXBlcmlv
ZF9zaXplKTsNCg0KCXIgPSBzbmRfcGNtX2Nsb3NlKHBjbSk7DQoJQ0hLKCJw
Y21fY2xvc2UiLCByKTsNCg0KCXJldHVybiAwOw0KfQ0K

--0-459525358-1205668740=:28063
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-459525358-1205668740=:28063--
