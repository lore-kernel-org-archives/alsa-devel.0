From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Kernel crashes for unsupported sample rates
Date: Thu, 15 May 2008 15:53:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022256EF29@dbde02.ent.ti.com>
References: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5A47E75E594F054BAF48C5E4FC4B92AB022256EF29dbde02enttico_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A7CD2477C
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 12:23:37 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4FANFKQ002981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 15 May 2008 05:23:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m4FAN3e1010752
	for <alsa-devel@alsa-project.org>; Thu, 15 May 2008 05:23:14 -0500 (CDT)
In-Reply-To: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_5A47E75E594F054BAF48C5E4FC4B92AB022256EF29dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I tried "pcm" sample application which is coming along with the alsa-libs p=
ackage (in the test folder). It works well for the sample rates supported b=
y my audio driver but gives me a kernel crash when tried with any other non=
-supporting sample rate. If the driver has explicitly said that these sampl=
e rates are not-supported, then the app should have exited gracefully inste=
ad of trying further.

The log is as below (attached also):

[root@MY_EVM bin]# ./pcm -r 10000 -v
Playback device is plughw:0,0
Stream parameters are 10000Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
Plug PCM: Rate conversion PCM (11025, sformat=3DS16_LE)
Its setup is:
Alignment trap: not handling instruction e1932f9f at [<c02317a0>]

  access       : RW_INTERLEAVEDUnhandled fault: alignment exception (0x001)=
 at 0x00000003

  format       : S16_LE
  subInternal error: : 1 [#5]
Modules linked in:
CPU: 0    Not tainted  (2.6.22.18-omap3 #1)
PC is at snd_pcm_mmap_data_nopage+0xb8/0xe4
LR is at 0xc7b71c00
pc : [<c02317a4>]    lr : [<c7b71c00>]    psr: 60000113
sp : c69c3e58  ip : c77f9460  fp : c69c3e6c
r10: 00000000  r9 : 402f2000  r8 : c7dc4f04
r7 : c77a7bd0  r6 : 00000000  r5 : c69c3e94  r4 : 402f2000
r3 : 00000003  r2 : bf3fe000  r1 : 00000000  r0 : c0be3540
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 00c5387f  Table: 807ec018  DAC: 00000015
Process pcm (pid: 324, stack limit =3D 0xc69c22d8)
Stack: (0xc69c3e58 to 0xc69c4000)
3e40:                                                       00000000 c69c20=
00
3e60: c69c3ec4 c69c3e70 c0092d2c c02316f8 c69c3e8c c69c3e80 c00580f4 c005c9=
9c
3e80: 00000800 c0025380 000003c8 c07ed008 174c3094 00000002 17bfac7c c03a60=
0c
3ea0: c055bd60 c77a7bd0 c00253b4 c0025380 c69c3fb0 402f2000 c69c3f04 c69c3e=
c8
3ec0: c0030fb0 c0092c08 174c3094 c0844123 0001f040 00000817 c055d6c0 c03a60=
0c
3ee0: 00000817 c69c3fb0 402f2000 0008d3dd 00000000 00000000 c69c3fac c69c3f=
08
3f00: c002a1e8 c0030ed8 c03b22e4 c0844123 0001f040 00000004 c055d6c0 c002af=
68
3f20: c69c3f3c c69c3f30 c02356bc c0235134 c69c3f54 c69c3f40 c00b166c c02356=
94
3f40: c055d6c0 0001f040 c69c3f7c c69c3f58 c00b1910 c00b1644 00000025 c03b30=
d0
3f60: 00000004 0001f040 c0844123 c055d6c0 c69c3fa4 c69c3f80 c00b1968 c00b16=
bc
3f80: c69c3fac 00000000 0001ef20 0001eee0 ffffffff 00000000 00000000 000000=
00
3fa0: 00000000 c69c3fb0 c002ad60 c002a1b8 402f2000 00000000 00000000 000000=
00
3fc0: 00080000 00000000 00000000 00000000 0008d3dd 00000000 00000000 000203=
98
3fe0: 00000000 bed06588 40088d30 40088d58 20000010 ffffffff 00000000 000000=
00
Backtrace:
[<c02316ec>] (snd_pcm_mmap_data_nopage+0x0/0xe4) from [<c0092d2c>] (__handl=
e_mm_fault+0x130/0x968)
 r5:c69c2000 r4:00000000
[<c0092bfc>] (__handle_mm_fault+0x0/0x968) from [<c0030fb0>] (do_page_fault=
+0xe4/0x218)
[<c0030ecc>] (do_page_fault+0x0/0x218) from [<c002a1e8>] (do_DataAbort+0x3c=
/0x9c)
[<c002a1ac>] (do_DataAbort+0x0/0x9c) from [<c002ad60>] (ret_from_exception+=
0x0/0x10)
Exception stack(0xc69c3fb0 to 0xc69c3ff8)
3fa0:                                     402f2000 00000000 00000000 000000=
00
3fc0: 00080000 00000000 00000000 00000000 0008d3dd 00000000 00000000 000203=
98
3fe0: 00000000 bed06588 40088d30 40088d58 20000010 ffffffff
 r7:00000000 r6:00000000 r5:00000000 r4:ffffffff
Code: 0590300c 11a03000 e2833004 e1932f9f (e2822001)
format    : STD
  channels     : 1
  rate         : 10000
  exact rate   : 10000 (10000/1)
  msbits       : 16
  buffer_size  : 14860
  period_size  : 928
  period_time  : 92879
  tick_time    : 7812
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 928
  xfer_align   : 1
  start_threshold  : 14848
  stop_threshold   : 14860
  silence_threshold: 0
  silence_size : 0
  boundary     : 973864960
Slave: Hardware PCM card 0 'TWL4030' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 11025
  exact rate   : 11025 (11025/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 92879
  tick_time    : 7812
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Segmentation fault


Is the driver not handling anything properly or is it the intended behavior=
? Please help.

Thanks and Regards,
Anuj Aggarwal



--_002_5A47E75E594F054BAF48C5E4FC4B92AB022256EF29dbde02enttico_
Content-Type: text/plain; name="unsupported_crash.txt"
Content-Description: unsupported_crash.txt
Content-Disposition: attachment; filename="unsupported_crash.txt"; size=4001;
	creation-date="Thu, 15 May 2008 15:42:43 GMT";
	modification-date="Thu, 15 May 2008 15:42:43 GMT"
Content-Transfer-Encoding: base64

W3Jvb3RATVlfRVZNIGJpbl0jIC4vcGNtIC1yIDEwMDAwIC12DQpQbGF5YmFjayBkZXZpY2UgaXMg
cGx1Z2h3OjAsMA0KU3RyZWFtIHBhcmFtZXRlcnMgYXJlIDEwMDAwSHosIFMxNl9MRSwgMSBjaGFu
bmVscw0KU2luZSB3YXZlIHJhdGUgaXMgNDQwLjAwMDBIeg0KVXNpbmcgdHJhbnNmZXIgbWV0aG9k
OiB3cml0ZQ0KUGx1ZyBQQ006IFJhdGUgY29udmVyc2lvbiBQQ00gKDExMDI1LCBzZm9ybWF0PVMx
Nl9MRSkNCkl0cyBzZXR1cCBpczoNCkFsaWdubWVudCB0cmFwOiBub3QgaGFuZGxpbmcgaW5zdHJ1
Y3Rpb24gZTE5MzJmOWYgYXQgWzxjMDIzMTdhMD5dDQoNCiAgYWNjZXNzICAgICAgIDogUldfSU5U
RVJMRUFWRURVbmhhbmRsZWQgZmF1bHQ6IGFsaWdubWVudCBleGNlcHRpb24gKDB4MDAxKSBhdCAw
eDAwMDAwMDAzDQoNCiAgZm9ybWF0ICAgICAgIDogUzE2X0xFDQogIHN1YkludGVybmFsIGVycm9y
OiA6IDEgWyM1XQ0KTW9kdWxlcyBsaW5rZWQgaW46DQpDUFU6IDAgICAgTm90IHRhaW50ZWQgICgy
LjYuMjIuMTgtb21hcDMgIzEpDQpQQyBpcyBhdCBzbmRfcGNtX21tYXBfZGF0YV9ub3BhZ2UrMHhi
OC8weGU0DQpMUiBpcyBhdCAweGM3YjcxYzAwDQpwYyA6IFs8YzAyMzE3YTQ+XSAgICBsciA6IFs8
YzdiNzFjMDA+XSAgICBwc3I6IDYwMDAwMTEzDQpzcCA6IGM2OWMzZTU4ICBpcCA6IGM3N2Y5NDYw
ICBmcCA6IGM2OWMzZTZjDQpyMTA6IDAwMDAwMDAwICByOSA6IDQwMmYyMDAwICByOCA6IGM3ZGM0
ZjA0DQpyNyA6IGM3N2E3YmQwICByNiA6IDAwMDAwMDAwICByNSA6IGM2OWMzZTk0ICByNCA6IDQw
MmYyMDAwDQpyMyA6IDAwMDAwMDAzICByMiA6IGJmM2ZlMDAwICByMSA6IDAwMDAwMDAwICByMCA6
IGMwYmUzNTQwDQpGbGFnczogblpDdiAgSVJRcyBvbiAgRklRcyBvbiAgTW9kZSBTVkNfMzIgIFNl
Z21lbnQgdXNlcg0KQ29udHJvbDogMDBjNTM4N2YgIFRhYmxlOiA4MDdlYzAxOCAgREFDOiAwMDAw
MDAxNQ0KUHJvY2VzcyBwY20gKHBpZDogMzI0LCBzdGFjayBsaW1pdCA9IDB4YzY5YzIyZDgpDQpT
dGFjazogKDB4YzY5YzNlNTggdG8gMHhjNjljNDAwMCkNCjNlNDA6ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDAwMDAwIGM2OWMyMDAwDQoz
ZTYwOiBjNjljM2VjNCBjNjljM2U3MCBjMDA5MmQyYyBjMDIzMTZmOCBjNjljM2U4YyBjNjljM2U4
MCBjMDA1ODBmNCBjMDA1Yzk5Yw0KM2U4MDogMDAwMDA4MDAgYzAwMjUzODAgMDAwMDAzYzggYzA3
ZWQwMDggMTc0YzMwOTQgMDAwMDAwMDIgMTdiZmFjN2MgYzAzYTYwMGMNCjNlYTA6IGMwNTViZDYw
IGM3N2E3YmQwIGMwMDI1M2I0IGMwMDI1MzgwIGM2OWMzZmIwIDQwMmYyMDAwIGM2OWMzZjA0IGM2
OWMzZWM4DQozZWMwOiBjMDAzMGZiMCBjMDA5MmMwOCAxNzRjMzA5NCBjMDg0NDEyMyAwMDAxZjA0
MCAwMDAwMDgxNyBjMDU1ZDZjMCBjMDNhNjAwYw0KM2VlMDogMDAwMDA4MTcgYzY5YzNmYjAgNDAy
ZjIwMDAgMDAwOGQzZGQgMDAwMDAwMDAgMDAwMDAwMDAgYzY5YzNmYWMgYzY5YzNmMDgNCjNmMDA6
IGMwMDJhMWU4IGMwMDMwZWQ4IGMwM2IyMmU0IGMwODQ0MTIzIDAwMDFmMDQwIDAwMDAwMDA0IGMw
NTVkNmMwIGMwMDJhZjY4DQozZjIwOiBjNjljM2YzYyBjNjljM2YzMCBjMDIzNTZiYyBjMDIzNTEz
NCBjNjljM2Y1NCBjNjljM2Y0MCBjMDBiMTY2YyBjMDIzNTY5NA0KM2Y0MDogYzA1NWQ2YzAgMDAw
MWYwNDAgYzY5YzNmN2MgYzY5YzNmNTggYzAwYjE5MTAgYzAwYjE2NDQgMDAwMDAwMjUgYzAzYjMw
ZDANCjNmNjA6IDAwMDAwMDA0IDAwMDFmMDQwIGMwODQ0MTIzIGMwNTVkNmMwIGM2OWMzZmE0IGM2
OWMzZjgwIGMwMGIxOTY4IGMwMGIxNmJjDQozZjgwOiBjNjljM2ZhYyAwMDAwMDAwMCAwMDAxZWYy
MCAwMDAxZWVlMCBmZmZmZmZmZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KM2ZhMDogMDAw
MDAwMDAgYzY5YzNmYjAgYzAwMmFkNjAgYzAwMmExYjggNDAyZjIwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDANCjNmYzA6IDAwMDgwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDhkM2RkIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDIwMzk4DQozZmUwOiAwMDAwMDAwMCBiZWQwNjU4
OCA0MDA4OGQzMCA0MDA4OGQ1OCAyMDAwMDAxMCBmZmZmZmZmZiAwMDAwMDAwMCAwMDAwMDAwMA0K
QmFja3RyYWNlOg0KWzxjMDIzMTZlYz5dIChzbmRfcGNtX21tYXBfZGF0YV9ub3BhZ2UrMHgwLzB4
ZTQpIGZyb20gWzxjMDA5MmQyYz5dIChfX2hhbmRsZV9tbV9mYXVsdCsweDEzMC8weDk2OCkNCiBy
NTpjNjljMjAwMCByNDowMDAwMDAwMA0KWzxjMDA5MmJmYz5dIChfX2hhbmRsZV9tbV9mYXVsdCsw
eDAvMHg5NjgpIGZyb20gWzxjMDAzMGZiMD5dIChkb19wYWdlX2ZhdWx0KzB4ZTQvMHgyMTgpDQpb
PGMwMDMwZWNjPl0gKGRvX3BhZ2VfZmF1bHQrMHgwLzB4MjE4KSBmcm9tIFs8YzAwMmExZTg+XSAo
ZG9fRGF0YUFib3J0KzB4M2MvMHg5YykNCls8YzAwMmExYWM+XSAoZG9fRGF0YUFib3J0KzB4MC8w
eDljKSBmcm9tIFs8YzAwMmFkNjA+XSAocmV0X2Zyb21fZXhjZXB0aW9uKzB4MC8weDEwKQ0KRXhj
ZXB0aW9uIHN0YWNrKDB4YzY5YzNmYjAgdG8gMHhjNjljM2ZmOCkNCjNmYTA6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDQwMmYyMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDAwDQozZmMwOiAwMDA4MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDA4ZDNkZCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAyMDM5OA0KM2ZlMDogMDAwMDAwMDAgYmVkMDY1ODggNDAwODhk
MzAgNDAwODhkNTggMjAwMDAwMTAgZmZmZmZmZmYNCiByNzowMDAwMDAwMCByNjowMDAwMDAwMCBy
NTowMDAwMDAwMCByNDpmZmZmZmZmZg0KQ29kZTogMDU5MDMwMGMgMTFhMDMwMDAgZTI4MzMwMDQg
ZTE5MzJmOWYgKGUyODIyMDAxKQ0KZm9ybWF0ICAgIDogU1REDQogIGNoYW5uZWxzICAgICA6IDEN
CiAgcmF0ZSAgICAgICAgIDogMTAwMDANCiAgZXhhY3QgcmF0ZSAgIDogMTAwMDAgKDEwMDAwLzEp
DQogIG1zYml0cyAgICAgICA6IDE2DQogIGJ1ZmZlcl9zaXplICA6IDE0ODYwDQogIHBlcmlvZF9z
aXplICA6IDkyOA0KICBwZXJpb2RfdGltZSAgOiA5Mjg3OQ0KICB0aWNrX3RpbWUgICAgOiA3ODEy
DQogIHRzdGFtcF9tb2RlICA6IE5PTkUNCiAgcGVyaW9kX3N0ZXAgIDogMQ0KICBzbGVlcF9taW4g
ICAgOiAwDQogIGF2YWlsX21pbiAgICA6IDkyOA0KICB4ZmVyX2FsaWduICAgOiAxDQogIHN0YXJ0
X3RocmVzaG9sZCAgOiAxNDg0OA0KICBzdG9wX3RocmVzaG9sZCAgIDogMTQ4NjANCiAgc2lsZW5j
ZV90aHJlc2hvbGQ6IDANCiAgc2lsZW5jZV9zaXplIDogMA0KICBib3VuZGFyeSAgICAgOiA5NzM4
NjQ5NjANClNsYXZlOiBIYXJkd2FyZSBQQ00gY2FyZCAwICdUV0w0MDMwJyBkZXZpY2UgMCBzdWJk
ZXZpY2UgMA0KSXRzIHNldHVwIGlzOg0KICBzdHJlYW0gICAgICAgOiBQTEFZQkFDSw0KICBhY2Nl
c3MgICAgICAgOiBNTUFQX0lOVEVSTEVBVkVEDQogIGZvcm1hdCAgICAgICA6IFMxNl9MRQ0KICBz
dWJmb3JtYXQgICAgOiBTVEQNCiAgY2hhbm5lbHMgICAgIDogMQ0KICByYXRlICAgICAgICAgOiAx
MTAyNQ0KICBleGFjdCByYXRlICAgOiAxMTAyNSAoMTEwMjUvMSkNCiAgbXNiaXRzICAgICAgIDog
MTYNCiAgYnVmZmVyX3NpemUgIDogMTYzODQNCiAgcGVyaW9kX3NpemUgIDogMTAyNA0KICBwZXJp
b2RfdGltZSAgOiA5Mjg3OQ0KICB0aWNrX3RpbWUgICAgOiA3ODEyDQogIHRzdGFtcF9tb2RlICA6
IE5PTkUNCiAgcGVyaW9kX3N0ZXAgIDogMQ0KICBzbGVlcF9taW4gICAgOiAwDQogIGF2YWlsX21p
biAgICA6IDEwMjQNCiAgeGZlcl9hbGlnbiAgIDogMQ0KICBzdGFydF90aHJlc2hvbGQgIDogMTYz
ODQNCiAgc3RvcF90aHJlc2hvbGQgICA6IDE2Mzg0DQogIHNpbGVuY2VfdGhyZXNob2xkOiAwDQog
IHNpbGVuY2Vfc2l6ZSA6IDANCiAgYm91bmRhcnkgICAgIDogMTA3Mzc0MTgyNA0KU2VnbWVudGF0
aW9uIGZhdWx0DQo=

--_002_5A47E75E594F054BAF48C5E4FC4B92AB022256EF29dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_5A47E75E594F054BAF48C5E4FC4B92AB022256EF29dbde02enttico_--
