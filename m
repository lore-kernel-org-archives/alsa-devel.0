From: Siu Kam Ming <ming@thizlinux.com>
Subject: Volume problem on SiS 7012.
Date: Fri, 7 Jun 2002 18:28:09 +0800 (HKT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206071806530.9315-200000@ns1>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2033526186-474951556-1023445689=:9315"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---2033526186-474951556-1023445689=:9315
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

I have a machine which use SiS chipset. For the result of lspci I known it
is using SiS 7012 as sound chip. It can play sound. But I can not tune the
volume for PCM channel. The volume of PCM channel only has 2 levels, mute
and maxmium. As the volume level of PCM  in mixer is not 0, the output
sound is maxmium. But this is not happen on playing CD. The CD channel
works normally. 

I try the module from Kernel 2.4.18 and alsa 0.9.0rc1. They have the same
result. I attached the result of lspci with this mail. 

Does anyone know how to solve this problem?

Regards,
Ming

---2033526186-474951556-1023445689=:9315
Content-Type: TEXT/plain; name="lspci-result.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0206071828090.9315@ns1>
Content-Description: 
Content-Disposition: attachment; filename="lspci-result.txt"

MDA6MDAuMCBIb3N0IGJyaWRnZTogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3Rl
bXMgW1NpU106IFVua25vd24gZGV2aWNlIDA2NTENCjAwOjAxLjAgUENJIGJy
aWRnZTogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgW1NpU10gNTU5MS81
NTkyIEFHUA0KMDA6MDIuMCBJU0EgYnJpZGdlOiBTaWxpY29uIEludGVncmF0
ZWQgU3lzdGVtcyBbU2lTXSA4NUM1MDMvNTUxMw0KMDA6MDIuMiBFdGhlcm5l
dCBjb250cm9sbGVyOiBTaWxpY29uIEludGVncmF0ZWQgU3lzdGVtcyBbU2lT
XSBTaVM5MDAgMTAvMTAwIEV0aGVybmV0IChyZXYgOTEpDQowMDowMi4zIEZp
cmVXaXJlIChJRUVFIDEzOTQpOiBTaWxpY29uIEludGVncmF0ZWQgU3lzdGVt
cyBbU2lTXSBPSENJIENvbXBsaWFudCBGaXJlV2lyZSBDb250cm9sbGVyDQow
MDowMi41IElERSBpbnRlcmZhY2U6IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0
ZW1zIFtTaVNdIDU1MTMgW0lERV0NCjAwOjAyLjYgTW9kZW06IFNpbGljb24g
SW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdOiBVbmtub3duIGRldmljZSA3MDEz
IChyZXYgYTApDQowMDowMi43IE11bHRpbWVkaWEgYXVkaW8gY29udHJvbGxl
cjogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgW1NpU10gU2lTNzAxMiBQ
Q0kgQXVkaW8gQWNjZWxlcmF0b3IgKHJldiBhMCkNCjAwOjAzLjAgVVNCIENv
bnRyb2xsZXI6IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIDcw
MDEgKHJldiAwZikNCjAwOjAzLjEgVVNCIENvbnRyb2xsZXI6IFNpbGljb24g
SW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIDcwMDEgKHJldiAwZikNCjAwOjAz
LjIgVVNCIENvbnRyb2xsZXI6IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1z
IFtTaVNdIDcwMDEgKHJldiAwZikNCjAwOjAzLjMgVVNCIENvbnRyb2xsZXI6
IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdOiBVbmtub3duIGRl
dmljZSA3MDAyDQowMTowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6
IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdOiBVbmtub3duIGRl
dmljZSA2MzI1DQo=
---2033526186-474951556-1023445689=:9315--

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
