From: <jfm3@ouroboros-complex.org>
Subject: Re: hdsploader 1.1
Date: Thu, 10 Jul 2003 17:42:21 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32898.24.225.156.130.1057884141.squirrel@webmail.ouroboros-complex.org>
References: <45125.81.51.162.201.1057777378.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030710174221_17619"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <45125.81.51.162.201.1057777378.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_20030710174221_17619
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

> You can find the new version of hdsploader here:
> http://www.undata.org/~thomas/

This seems to break if you have other sound cards in /etc/modules.conf
that are not loaded yet. Probably my modules.conf is not correct. It is
attached.



I start the system. The red light on the Multiface is on. No sound drivers
are loaded yet. My modules.conf is as you see it.

[jfm3@localhost jfm3]$ sudo hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : RME Hammerfall DSP at 0xe9020000, irq 12
Upload firmware for card hw:0
Firmware uploaded for card hw:0
Card 1 :

The red light goes out. I can get sound if I mess around with gamix and
amixer enough, although I still haven't figured out what all the numbers
mean.

Shouldn't that be card 3 as the hdsp? In modules.conf I have the hdsp at
index 3. I don't understand exactly what the card "index" means.

If I have snd-virmidi not commented out and follow the above procedure, I
get a kernel oops when I run hdsploader but otherwise the same results.

Thank you very much everyone for all your hard work. I only hope I get the
chance to return the favor one day.

(jfm3)



------=_20030710174221_17619
Content-Type: application/octet-stream; name="modules.conf"
Content-Disposition: attachment; filename="modules.conf"
Content-Transfer-Encoding: base64

IyBQQ0kgZXRoZXJuZXQgY2FyZCwgbm90IHRoZSBuZm9yY2Ugb25lCmFsaWFzIGV0aDAgdHVsaXAK
CmFsaWFzIHVzYi1jb250cm9sbGVyIHVzYi1vaGNpCgphbGlhcyBpZWVlMTM5NC1jb250cm9sbGVy
IG9oY2kxMzk0CgojIFBBWSBDTE9TRSBBVFRFTlRJT04gdG8gY2FyZHNfbGltaXQKYWxpYXMgY2hh
ci1tYWpvci0xMTYgc25kCm9wdGlvbnMgc25kIG1ham9yPTExNiBjYXJkc19saW1pdD0xMSBkZXZp
Y2VfbW9kZT0wNjY2CmFsaWFzIGNoYXItbWFqb3ItMTQgc291bmRjb3JlCiMgUENJIGNvbnN1bWVy
IGF1ZGlvIGNhcmQsIG5vdCB0aGUgbmZvcmNlIG9uZQphbGlhcyBzbmQtY2FyZC0wIHNuZC10cmlk
ZW50CmFsaWFzIHNuZC1zbG90LTAgc25kLWNhcmQtMAphbGlhcyBzb3VuZC1zZXJ2aWNlLTAtMCBz
bmQtbWl4ZXItb3NzCmFsaWFzIHNvdW5kLXNlcnZpY2UtMC0xIHNuZC1zZXEtb3NzCmFsaWFzIHNv
dW5kLXNlcnZpY2UtMC0zIHNuZC1wY20tb3NzCmFsaWFzIHNvdW5kLXNlcnZpY2UtMC04IHNuZC1z
ZXEtb3NzCmFsaWFzIHNvdW5kLXNlcnZpY2UtMC0xMiBzbmQtcGNtLW9zcwpvcHRpb25zIC1rIHNu
ZC10cmlkZW50IGluZGV4PTAKIyBzb21laG93IHdlIGhhdmUgdG8gdW5sb2FkIHBhcnBvcnQgbW9k
dWxlcyBmaXJzdAojIGNhbGxpbmcgL3NiaW4vbW9kcHJvYmUgZnJvbSBtb2R1bGVzLmNvbmYgb3Vn
aHQgdG8gYmUgaWxsZWdhbAphbGlhcyBzbmQtY2FyZC0xIHNuZC1tdHBhdgphbGlhcyBzbmQtc2xv
dC0xIHNuZC1jYXJkLTEKb3B0aW9ucyAtayBzbmQtbXRwYXYgaW5kZXg9MSBpcnE9NyBwb3J0PTB4
Mzc4CnByZS1pbnN0YWxsIHNuZC1tdHBhdiAvc2Jpbi9tb2Rwcm9iZSAtciBscCBwYXJwb3J0X3Bj
IHBhcnBvcnQKIyBtdWx0aWZhY2UgaGRzcAphbGlhcyBzbmQtY2FyZC0yIHNuZC1oZHNwCmFsaWFz
IHNuZC1zbG90LTIgc25kLWNhcmQtMgojIGdhemlsbGlvbiAoZWlnaHQpIHNuZC12aXJtaWRpIGRl
dmljZXMgdG8gT1NTaXplIHRoZSBtdHBhdgojYWxpYXMgc25kLWNhcmQtMyBzbmQtdmlybWlkaQoj
YWxpYXMgc25kLXNsb3QtMyBzbmQtY2FyZC0zCiNhbGlhcyBzbmQtY2FyZC00IHNuZC12aXJtaWRp
CiNhbGlhcyBzbmQtc2xvdC00IHNuZC1jYXJkLTQKI2FsaWFzIHNuZC1jYXJkLTUgc25kLXZpcm1p
ZGkKI2FsaWFzIHNuZC1zbG90LTUgc25kLWNhcmQtNQojYWxpYXMgc25kLWNhcmQtNiBzbmQtdmly
bWlkaQojYWxpYXMgc25kLXNsb3QtNiBzbmQtY2FyZC02CiNhbGlhcyBzbmQtY2FyZC03IHNuZC12
aXJtaWRpCiNhbGlhcyBzbmQtc2xvdC03IHNuZC1jYXJkLTcKI2FsaWFzIHNuZC1jYXJkLTggc25k
LXZpcm1pZGkKI2FsaWFzIHNuZC1zbG90LTggc25kLWNhcmQtOAojYWxpYXMgc25kLWNhcmQtOSBz
bmQtdmlybWlkaQojYWxpYXMgc25kLXNsb3QtOSBzbmQtY2FyZC05CiNhbGlhcyBzbmQtY2FyZC0x
MCBzbmQtdmlybWlkaQojYWxpYXMgc25kLXNsb3QtMTAgc25kLXZpcm1pZGkKIyB3aG8ga25vd3Mg
d2hhdCB0aGlzIGRvZXM/CiNvcHRpb25zIC1rIHNuZC12aXJtaWRpIGluZGV4PTMsNCw1LDYsNyw4
LDksMTAgZW5hYmxlPTEsMSwxLDEsMSwxLDEsMSBtaWRpX2RldnM9MiwyLDIsMiwyLDIsMiwyCg==

------=_20030710174221_17619--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
