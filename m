From: tom burkart <alsa@aussec.com>
Subject: Re: Oops with snd-ymfpci and ALSA 0.9.3a
Date: Thu, 12 Jun 2003 22:44:44 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306122242060.1298-300000@home.aussec.com>
References: <Pine.LNX.4.44.0306121253150.1795-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-843262512-1055421884=:1298"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306121253150.1795-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463809536-843262512-1055421884=:1298
Content-Type: TEXT/PLAIN; charset=US-ASCII

Today, Jaroslav Kysela wrote:

> In that case, we might compare PCI registers (lspci -s<DEV> -xxx).
The two dumps are attached: snd-ymfpci for alsa the ymfpci for oss...

tom.

---1463809536-843262512-1055421884=:1298
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=snd-ymfpci
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0306122244440.1298@home.aussec.com>
Content-Description: alsa hex dump
Content-Disposition: attachment; filename=snd-ymfpci

MDA6MGMuMCBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IFlhbWFoYSBD
b3Jwb3JhdGlvbiBZTUYtNzQ0QiBbRFMtMVMgQXVkaW8gQ29udHJvbGxlcl0g
KHJldiAwMikNCjAwOiA3MyAxMCAxMCAwMCAwNyAwMCAxMCA4MiAwMiAwMCAw
MSAwNCAwMCA0MCAwMCAwMA0KMTA6IDAwIDgwIGZmIGVmIDAxIGZmIDAwIDAw
IGZkIGZlIDAwIDAwIDAwIDAwIDAwIDAwDQoyMDogMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgNzkgMTEgMDEgMDANCjMwOiAwMCAwMCAw
MCAwMCA1MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwYiAwMSAwNSAxOQ0KNDA6
IDFhIDAwIDAwIDg4IDc5IDExIDAxIDAwIDA4IDAwIDAwIDAwIDAwIDAwIDAw
IDAwDQo1MDogMDEgMDAgMDEgMDQgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDANCjYwOiAwMCBmZiAyMCAwMiAyMCBmZiAwMSAwMiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMA0KNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo4MDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCjkwOiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0K
YTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwDQpiMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDANCmMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KZDA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQplMDogMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCmYwOiAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MA0KDQo=
---1463809536-843262512-1055421884=:1298
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=ymfpci
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0306122244441.1298@home.aussec.com>
Content-Description: OSS hex dump
Content-Disposition: attachment; filename=ymfpci

MDA6MGMuMCBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IFlhbWFoYSBD
b3Jwb3JhdGlvbiBZTUYtNzQ0QiBbRFMtMVMgQXVkaW8gQ29udHJvbGxlcl0g
KHJldiAwMikNCjAwOiA3MyAxMCAxMCAwMCAwNyAwMCAxMCA4MiAwMiAwMCAw
MSAwNCAwMCA0MCAwMCAwMA0KMTA6IDAwIDgwIGZmIGVmIDAxIGZmIDAwIDAw
IGZkIGZlIDAwIDAwIDAwIDAwIDAwIDAwDQoyMDogMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgNzkgMTEgMDEgMDANCjMwOiAwMCAwMCAw
MCAwMCA1MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwYiAwMSAwNSAxOQ0KNDA6
IDdmIDkwIDAwIDg4IDc5IDExIDAxIDAwIDA4IDAwIDAwIDAwIDAwIDAwIDAw
IDAwDQo1MDogMDEgMDAgMDEgMDQgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDANCjYwOiAwMCBmZiAyMCAwMiAyMCBmZiAwMSAwMiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMA0KNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo4MDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCjkwOiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0K
YTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwDQpiMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDANCmMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KZDA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQplMDogMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCmYwOiAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MA0KDQo=
---1463809536-843262512-1055421884=:1298--


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
