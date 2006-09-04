From: Cruise X Overide <cruiseoveride@gmail.com>
Subject: M-Audio Audiophile 192 (ap192k)
Date: Mon, 04 Sep 2006 18:57:15 -0400
Message-ID: <1157410635.3658.17.camel@server>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear All

In the past 2 months I have been working with a FreeBSD developer and
have got the M-Audio Audiophile 192 working on FreeBSD 6.1 .


The M-Audio Audiophile 192 (ap192k) is as follows

PCI IDs
	SubVen ID -> 0x1412 
	SubDev ID -> 0x3632
Envy24 Controller => Envy24HT
DAC -> AK4358
DIT -> AK4114
ADC -> AK5385A

Here is the Wiring Info

AK4358 <---> Envy24HT
=======================
AK4358 CCLK pin 19 <-> Envy24HT GPIO1 pin 51
AK4358 CDTI pin 20 <-> Envy24HT GPIO3 pin 53
? AK4358 CSN pin 21 <-> Envy24HT GPIO4 pin 56
or
? AK4358 CSN pin 21 <-> Envy24HT GPIO5 pin 57
=======================

AK4114 <---> Envy24HT
=======================
AK4114 CDTO pin 32 <-> Envy24HT GPIO2 pin 52
AK4114 CDTI pin 33 <-> Envy24HT GPIO3 pin 53
AK4114 CCLK pin 34 <-> Envy24HT GPIO1 pin 51
AK4114 CSN pin 35 <-> Envy24HT GPIO7 pin 59
=======================

AK5385A <---> Envy24HT
=======================
AK5385A CKS0 pin 6 <-> Not Connected ? 
AK5385A DFS0 pin 18 <-> Envy24HT GPIO10 pin 77
AK5385A DFS1 pin 20 <-> ???
=======================

GPIO DIR, MASK, STATE
=======================
GPIO DIR:  0x7FFFBA
GPIO MASK: 0x45
GPIO STATE: 0x4000B5
=======================

E2PROM
=======================
SCFG:	0x68
ACL:	0x80
I2S:	0xf8
SPDIF:	0xc3
=======================

AP192 E2prom Dump
=======================

    | 00 01 02 03 04 05 06 07 08 09 0A 0B 0C OD 0E 0F
----+-------------------------------------------------
 00 | 36 32 14 12 13 02 68 80 f8 c3 ba ff 7f 45 00 00
 01 | b5 00 40 ff ff ff ff ff ff ff ff ff ff ff ff ff


The following are the fruits of the development done in BSD
http://xkodi.svobodno.com/xkodi/ap192/envy24ht/envy24ht.h
http://xkodi.svobodno.com/xkodi/ap192/envy24ht/envy24ht.c
http://xkodi.svobodno.com/xkodi/ap192/ak4358/ak4358.h
http://xkodi.svobodno.com/xkodi/ap192/ak4358/ak4358.c


I have been looking at the Juli@ code for a while now, and this card (ap192k) is 
almost identical to the ESI. But i have absolutely no experience programming drivers at all.
With the information i have provided, will it be possible to see support for this card in the next rc of ALSA
pretty please??

Sincerely,

CruiseX


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
