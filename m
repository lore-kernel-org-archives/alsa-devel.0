From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: Test Report: snd-asihpi with an ASI6114
Date: Thu, 26 Jun 2003 15:09:06 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030626150906.20849.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1056665346-20849-2"
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: fredg@salemradiolabs.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1056665346-20849-2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: binary

Fred Gleason wrote:

> I've got things working with my ASI6114.  Playback works well.
> 
> Alsamixer shows me a bewildering array of controls, few of which seem to do 
> anything.  How do I control stream levels?

Are you using the latest 0.9.4 alsamixer?  Versions prior to that dont work with
the -ve dB control values.

"Linein Linout1 1"   is a volume control between linein 1 and LineOut1
"OutStr LinOut1 1"   ditto from Outstream 1 to Lineout1

alsamixer strips "Volume" off the name, but as Guiliano said, you can see all
the controls using "amixer controls" - you'll see lines like:

numid=2,iface=MIXER,name='OutStr LinOut1 Volume',index=2

Doing just "amixer" will show more details about each control including the
range of values.

To read a control (and see its type and range)
    amixer cget numid=2 
or  amixer cget name='OutStr LinOut1 Volume',index=2

To set this volume to -10dB
  amixer cset numid=2 -- -10,-10
(You need the "--" when using -ve parameters - thanks Guiliano ;-)

Note that for labelling purposes, the indices are 1-based.  (When the index==0,
it doesn't get displayed, which is confusing!)

Attached updated readme file with a few more details.

regards

Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html
------------=_1056665346-20849-2
Content-Type: application/octet-stream; name="README.ASIHPI"
Content-Disposition: attachment; filename="README.ASIHPI"
Content-Transfer-Encoding: base64

V0FSTklORyEhISBUSElTIElTIEFOIEFMUEhBIERSSVZFUiwgVVNFIEFUIFlP
VVIgT1dOIFJJU0sgClNlbmQgZmVlZGJhY2sgdG8gPGVibGVubmVyaGFzc2V0
dEBhdWRpb3NjaWVuY2UuY29tPgpUaGlzIHNvZnR3YXJlIGlzIGRpc3RyaWJ1
dGVkIHVuZGVyIHRoZSBHUEwgLSBzZWUgYXNpaHBpLmMgCgpTVVBQT1JURUQg
Q0FSRFMKVGhpcyBhcHBsaWNhYmxlIHRvIEFTSTZ4eHgsIEFTSTUxMTEsIEFT
STQzeHggY2FyZHMuCihTZWUgYWxzbyBMSU1JVEFUSU9OcyBzZWN0aW9uKQoK
SE9XIFRPIElOU1RBTEwKVGhlIHBhdGNoIGFwcGxpZXMgdG8gdGhlIHN0YW5k
YXJkIGRyaXZlciB0cmVlIG9idGFpbmVkIGZyb20gYWxzYS1kcml2ZXItMC45
LjQudGFyLmJ6MgoKSSBhc3N1bWUgdGhhdAoqIFlvdSBoYXZlIHRoZSBwYXRj
aCBmaWxlIGluIHRoZSBkaXJlY3RvcnkgdGhhdCBjb250YWlucyB0aGUgYWZv
cmVtZW50aW9uZWQgZHJpdmVyLgoqIFlvdSBoYXZlIGluc3RhbGxlZCBidWls
dCBhbmQgdGVzdGVkIHRoZSBIUEkgZHJpdmVyIGtpdAooaHR0cDovL3d3dy5h
dWRpb3NjaWVuY2UuY29tL2ludGVybmV0L2Rvd25sb2FkL2hwa2xpbnV4LTI4
MWdwbC50YXIuZ3opCiBzb21ld2hlcmUgZWxzZSBlZyBpbiB+L2FzaS9ocGts
aW51eC0yODFncGwKCgokIHBhdGNoIC1wMSAtZCBhbHNhLWRyaXZlci0wLjks
NCA8IGFsc2EtZHJpdmVyLTAuOS40YXNpaHBpLnBhdGNoCiQgY2QgYWxzYS1k
cml2ZXItMC45LjQvcGNpCiQgbG4gLXMgfi9hc2kvaHBrbGludXgtMjgxZ3Bs
L2hwaS9ocGkuaCBocGkuaAokIGNkIC4uCiQgLi9jdnNjb21waWxlIC0td2l0
aC1jYXJkcz1hc2locGksPG90aGVyIGNhcmRzPgokIG5vdyBmb2xsb3cgbm9y
bWFsIGJ1aWxkIHVzaW5nIG1ha2UsIG1ha2UgaW5zdGFsbCwgLi9zbmRkZXZp
Y2VzIAoKTU9EVUxFIE9QVElPTlMKbWl4ZXJfZHVtcD0xICAgRW5hYmxlcyBs
b2dnaW5nIG9mIG1peGVyIGNvbnRyb2xzIHRvIHRoZSBtZXNzYWdlIGxvZy4g
IFlvdSBjYW4gc2VlIHdoaWNoIGNvbnRyb2xzIGhhdmUgYmVlbiBjb252ZXJ0
ZWQgdG8gQUxTQSBjb250cm9scywgYW5kIHdoaWNoIGhhdmVuJ3QuCgpUaGUg
cGF0Y2ggbW9kaWZpZXMgdGhlIGZvbGxvd2luZyBmaWxlczoKCWFsc2EtZHJp
dmVyLTAuOS40L3BjaS9NYWtlZmlsZQoJYWxzYS1kcml2ZXItMC45LjQvYWxz
YS1rZXJuZWwvaW5jbHVkZS9zbmRtYWdpYy5oCglhbHNhLWRyaXZlci0wLjku
NC91dGlscy9Nb2R1bGVzLmRlcAoJYWxzYS1kcml2ZXItMC45LjQvYWNvcmUv
TWFrZWZpbGUKQW5kIGNyZWF0ZXMKCWFsc2EtZHJpdmVyLTAuOS40L3BjaS9h
c2locGkuYwoKQ0FSRCBJTkRJQ0VTCnNuZC1hc2locGkgd2lsbCB0cnkgdG8g
YWxsb2NhdGUgdGhlIEFMU0EgY2FyZCBpbmRleCBlcXVhbCB0byB0aGUgQVNJ
IGNhcmQgaW5kZXggc2V0IGJ5IHRoZSBqdW1wZXJzIG9uIHRoZSBjYXJkLgpI
b3dldmVyLCBpZiB5b3UgaGF2ZSBhbm90aGVyIHNvdW5kIGNhcmQgaW5zdGFs
bGVkLCBhbmQgaXRzIGRyaXZlciBpcyBsb2FkZWQgZmlyc3QsIGl0IG1heSBh
bHJlYWR5IGhhdmUgYmVlbiBhc3NpZ25lZCB0aGUgc2FtZSBpbmRleCAodXN1
YWxseSB6ZXJvKS4KSW4gdGhpcyBjYXNlIHRoZSBBU0kgY2FyZCB3aWxsIGdl
dCB0aGUgbmV4dCBhdmFpbGFibGUgQUxTQSBpbmRleC4KCllvdSBtYXkgYmUg
YWJsZSB0byBhZGQgdG8geW91ciBtb2R1bGVzLmNvbmYgCiAgIG9wdGlvbnMg
c25kLTxvdGhlcmNhcmQ+IGluZGV4PTIgCnRvIGZyZWUgdXAgdGhlIGRlc2ly
ZWQgaW5kaWNlcyBmb3IgeW91ciBBU0kgY2FyZHMuCgpBU0kgc3RyZWFtcyBt
YXAgdG8gQUxTQSBzdWJkZXZpY2VzLiBEZXZpY2UgaXMgYWx3YXlzIHplcm8u
CmFwbGF5IC1EaHc6MCwwLDIgc291bmQud2F2ICMgUGxheSBvbiAzcmQgc3Ry
ZWFtIG9mIGNhcmQwCgoKTElNSVRBVElPTlMKVGhpcyBkcml2ZXIgaXMgb25s
eSBhcHBsaWNhYmxlIHRvIEFTSTZ4eHgsIEFTSTUxMTEsIEFTSTQzeHggY2Fy
ZHMKKFlvdSBtYXkgYmUgYWJsZSB0byBhY2Nlc3MgcGxheSBhbmQgcmVjb3Jk
IHN0cmVhbXMgb24gb3RoZXIgY2FyZHMsIGJ1dCBubyBtaXhlciBjb250cm9s
cyB3aWxsIGJlIGF2YWlsYWJsZSkKCk9ubHkgMTYgYml0IHNpZ25lZCBQQ00g
aXMgY3VycmVudGx5IHN1cHBvcnRlZC4KCkNvbnRyb2xzOgpUbyBsaXN0IHRo
ZW0gYWxsCiQgYW1peGVyIGNvbnRyb2xzCgpOb3RlIHRoYXQgY29udHJvbCBp
bmRpY2VzIGFyZSAxLWJhc2VkIGZvciBkaXNwbGF5IHB1cnBvc2VzICh3aGls
ZSBzdWJkZXZpY2UgaW5kaWNlcyBhcmUgMC1iYXNlZCkKQUxTQSB0cmVhdHMg
Y29udHJvbHMgd2l0aCBpbmRleD09MCBkaWZmZXJlbnRseSAoYXQgbGVhc3Qg
YW1peGVyIGFuZCBhbHNhbWl4ZXIgZG8pLiAgCgoiTGluZU91dCBMZXZlbCwg
aW5kZXg9MSIgcmVmZXJzIHRvIHRoZSBmaXJzdCBwaHlzaWNhbCBvdXB1dAoi
T3V0U3RyIExpbk91dDEgVm9sdW1lLCBpbmRleD0xIGlzIGEgdm9sdW1lIGNv
bnRyb2wgYmV0d2VlbiB0aGUgZmlyc3Qgc3RyZWFtIGFuZCB0aGUgZmlyc3Qg
b3V0cHV0LgoKVGhlIGN1cnJlbnQgZGVmYXVsdCBmb3IgY29udHJvbCBuYW1p
bmcgaXMgdG8gdXNlIEFTSSBzdHlsZSBuYW1lcyAoT3V0U3RyZWFtLCBJblN0
cmVhbSBldGMpIGJ1dCBpdCBjYW4gYmUgY29tcGlsZWQgd2l0aCBBTFNBIHN0
eWxlIG5hbWVzIChQQ00sIFBDTSwgZXRjKSBzZWUgYXNpaHBpLmMgbGluZSAy
NyBhbmQgdGhlIGNvcnJlc3BvbmRpbmcgI2lmZGVmcwoKClZvbHVtZSBhbmQg
bGV2ZWwgY29udHJvbHM6ClRoZSB1bml0cyBvZiB2b2x1bWUgYW5kIGxldmVs
IGNvbnRyb2xzIGFyZSBkZWNpQmVscy4gIFRoZSBsaW1pdHMgYXJlIHJlcG9y
dGVkIGNvcnJlY3RseSBieSBhbWl4ZXIuClR5cGljYWxseSB2b2x1bWUgY29u
dHJvbHMgcmFuZ2UgZnJvbSAtMTkyIG9yIC0xMDAgdG8gMCAKTGV2ZWwgY29u
dHJvbHMgcmFuZ2UgZnJvbSBhYm91dCAtMTBkQnUgdG8gKCsyMGRCdSB1cCB0
byArMjZkQnUpCgpUbyBzZXQgYSB2b2x1bWUgY29udHJvbCB0byAtMTBkQiAo
eW91IG5lZWQgdGhlICItLSIgd2hlbiB1c2luZyAtdmUgcGFyYW1ldGVyIHZh
bHVlcykKCWFtaXhlciBjc2V0IG51bWlkPTUgLS0gLTEwIC0xMAoKTXVsdGlw
bGV4ZXIgY29udHJvbHMKTWV0ZXIgY29udHJvbHMgYXJlIHBhcnRpYWxseSBz
dXBwb3J0ZWQuCk1ldGVycyBhcmUgc3VwcG9zZWQgdG8gcmV0dXJuIGxldmVs
cyBpbiBtaWxsaUJlbHMsIGJ1dCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biByZXF1aXJlcyBmbG9hdGluZyBwb2ludCBvbiB0aGUgaG9zdCwgd2hpY2gg
aXMgbm90IGZlYXNpYmxlIGluIGEga2VybmVsIGRyaXZlci4KU3RpbGwgbG9v
a2luZyBmb3IgYSBzb2x1dGlvbiBoZXJlLgpWYWx1ZXMgcmV0dXJuZWQgd2ls
bCByYW5nZSBiZXR3ZWVuIC0xOTIwMCBhbmQgMCwgYW5kIGFyZSBtb25vdG9u
aWNhbGx5IHJlbGF0ZWQgdG8gdGhlIGxldmUsIGJ1dCBuaXRoZXIgbG9nIG5v
ciBsaW5lYXIuCgpPdGhlciBjb250cm9scyAoYWVzZWJ1LCBjb21wYW5kZXIs
IHBhcmFtZXRyaWMgZXF1YWxpemVyLCB2b3gsIGJpdHN0cmVhbSwgbWljcm9w
aG9uZSwgc2FtcGxlY2xvY2spCmFyZSBjdXJyZW50bHkgdW5zdXBwb3J0ZWQu
ClZvbHVtZSBhdXRvZmFkZSBpcyBub3Qgc3VwcG9ydGVkLgo=

------------=_1056665346-20849-2--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
