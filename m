From: Patrick Boettcher <patrick.boettcher@desy.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Tue, 6 Apr 2004 22:01:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404062154190.8104@pub6.ifh.de>
References: <Pine.HPX.4.33n.0404061619410.24331-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="579704577-1752028969-1081281673=:8104"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404061619410.24331-200000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--579704577-1752028969-1081281673=:8104
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 6 Apr 2004, Clemens Ladisch wrote:

> I wrote:
> > I think I'll write a quirk for this ...
>
> Please try the attached patch.

Sorry, don't have lots time now, I only applied the patch, loaded the
module, pluged in the device ... result is attached.

Unfortunately I'm (still) not familar with ksymoops to resolve a problem.
If there is more time, I will learn and hopefully understand.

So far,
Patrick
--579704577-1752028969-1081281673=:8104
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=oops
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=oops

VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmly
dHVhbCBhZGRyZXNzIDJlMmYyZTJlDQogcHJpbnRpbmcgZWlwOg0KYzAxMTk5
OWQNCipwZGUgPSAwMDAwMDAwMA0KT29wczogMDAwMCBbIzFdDQpQUkVFTVBU
IA0KQ1BVOiAgICAwDQpFSVA6ICAgIDAwNjA6WzxjMDExOTk5ZD5dICAgIFRh
aW50ZWQ6IFBGIA0KRUZMQUdTOiAwMDAxMDAwNyAgICgyLjYuNSkgDQpFSVAg
aXMgYXQgX193YWtlX3VwX2NvbW1vbisweDEzLzB4NTANCmVheDogY2Q5NjM3
NDAgICBlYng6IGM1Y2Y2MDAwICAgZWN4OiAwMDAwMDAwMSAgIGVkeDogMmUy
ZjJlMmUNCmVzaTogMDAwMDAyOTIgICBlZGk6IDAwMDAwMDAxICAgZWJwOiBj
NWNmN2VlNCAgIGVzcDogYzVjZjdlY2MNCmRzOiAwMDdiICAgZXM6IDAwN2Ig
ICBzczogMDA2OA0KUHJvY2VzcyBzZWQgKHBpZDogNTgzOSwgdGhyZWFkaW5m
bz1jNWNmNjAwMCB0YXNrPWM3MDAxMjYwKQ0KU3RhY2s6IDAwMDAwMDAwIDQw
MGYwMDdiIDAwMDAwMDdiIGM1Y2Y2MDAwIDAwMDAwMjkyIGRmYzhkNDVlIGM1
Y2Y3ZjA0IGMwMTE5YTBjIA0KICAgICAgIGNkOTYzNzQwIDAwMDAwMDAxIDAw
MDAwMDAxIDAwMDAwMDAwIGM2N2Y3YjAwIGM1Y2Y3ZjZjIDAwMDAwMDAwIGMw
MTVjYzFlIA0KICAgICAgIDQwMDE4MDAwIGRmYzhkNDVlIDAwMDAxMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIGM1Y2Y2MDAwIGM1Y2Y2MDAwIA0K
Q2FsbCBUcmFjZToNCiBbPGMwMTE5YTBjPl0gX193YWtlX3VwKzB4MzIvMHg1
Nw0KIFs8YzAxNWNjMWU+XSBwaXBlX3JlYWR2KzB4Mjg4LzB4MmQ4DQogWzxj
MDE1Y2NhNT5dIHBpcGVfcmVhZCsweDM3LzB4M2INCiBbPGMwMTUwZDc0Pl0g
dmZzX3JlYWQrMHhkMC8weDEzNQ0KIFs8YzAxNTEwMDc+XSBzeXNfcmVhZCsw
eDQyLzB4NjMNCiBbPGMwMTA3MWVmPl0gc3lzY2FsbF9jYWxsKzB4Ny8weGIN
Cg0KQ29kZTogOGIgMzIgNzQgMzEgOGIgNWEgZjQgOGQgNDIgZjQgOGIgNTUg
MTQgODkgNTQgMjQgMDggODkgMDQgMjQgDQogPDY+bm90ZTogc2VkWzU4Mzld
IGV4aXRlZCB3aXRoIHByZWVtcHRfY291bnQgMQ0KVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIDYy
NzM3NTNiDQogcHJpbnRpbmcgZWlwOg0KYzAxNjIyMTYNCipwZGUgPSAwMDAw
MDAwMA0KT29wczogMDAwMCBbIzJdDQpQUkVFTVBUIA0KQ1BVOiAgICAwDQpF
SVA6ICAgIDAwNjA6WzxjMDE2MjIxNj5dICAgIFRhaW50ZWQ6IFBGIA0KRUZM
QUdTOiAwMDAxMDAwMiAgICgyLjYuNSkgDQpFSVAgaXMgYXQgZmFzeW5jX2hl
bHBlcisweDM5LzB4ZWQNCmVheDogYzcxNjIwMDAgICBlYng6IDAwMDAwMDAw
ICAgZWN4OiBjZDk2Mzc2OCAgIGVkeDogNjI3Mzc1MmYNCmVzaTogY2VkZWZi
ODAgICBlZGk6IGNkOTYzNzY4ICAgZWJwOiAwMDAwMDAwMCAgIGVzcDogYzcx
NjNmMmMNCmRzOiAwMDdiICAgZXM6IDAwN2IgICBzczogMDA2OA0KUHJvY2Vz
cyB1c2IuYWdlbnQgKHBpZDogNTgyOCwgdGhyZWFkaW5mbz1jNzE2MjAwMCB0
YXNrPWQzMGQwNmEwKQ0KU3RhY2s6IGM3MTYyMDAwIDAwMDMwMDAyIDAwMDAw
MDAwIGM2N2Y3YjY4IGM2N2Y3YjAwIGRmZTllMzAwIGM2N2Y3YjAwIGMwMTVk
MjQ0IA0KICAgICAgIGZmZmZmZmZmIGNlZGVmYjgwIDAwMDAwMDAwIGNkOTYz
NzY4IGNlZGVmYjgwIGMwMTVkMzZiIGMwMTVkMzhhIGZmZmZmZmZmIA0KICAg
ICAgIGNlZGVmYjgwIDAwMDAwMDAwIGMwMTUxZTUwIGM2N2Y3YjAwIGNlZGVm
YjgwIGM1YjM0MjgwIGNlZGVmYjgwIDAwMDAwMDAwIA0KQ2FsbCBUcmFjZToN
CiBbPGMwMTVkMjQ0Pl0gcGlwZV9yZWFkX2Zhc3luYysweDQ4LzB4NjgNCiBb
PGMwMTVkMzZiPl0gcGlwZV9yZWFkX3JlbGVhc2UrMHgwLzB4M2YNCiBbPGMw
MTVkMzhhPl0gcGlwZV9yZWFkX3JlbGVhc2UrMHgxZi8weDNmDQogWzxjMDE1
MWU1MD5dIF9fZnB1dCsweDExNi8weDEyOA0KIFs8YzAxNTA1NjI+XSBmaWxw
X2Nsb3NlKzB4NTkvMHg4Ng0KIFs8YzAxNTA1ZjI+XSBzeXNfY2xvc2UrMHg2
My8weDk2DQogWzxjMDEwNzFlZj5dIHN5c2NhbGxfY2FsbCsweDcvMHhiDQoN
CkNvZGU6IDM5IDcyIDBjIDc0IDUzIDhkIDRhIDA4IDhiIDUyIDA4IDg1IGQy
IDc1IGYxIDg1IGVkIDc0IDFmIGM3IA0KIDw2Pm5vdGU6IHVzYi5hZ2VudFs1
ODI4XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDENCg==

--579704577-1752028969-1081281673=:8104--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
