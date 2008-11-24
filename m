From: =?UTF-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?=
 <vilinkamen@mail.ru>
Subject: MSI 7260 patch
Date: Mon, 24 Nov 2008 18:29:59 +0100
Message-ID: <492AE497.9000601@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050802050603060206000908"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx27.mail.ru (mx27.mail.ru [194.67.23.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A819243B4
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 18:39:04 +0100 (CET)
Received: from [213.244.194.230] (port=46235 helo=[213.244.194.230])
	by mx27.mail.ru with asmtp id 1L4fOP-0005xR-00
	for alsa-devel@alsa-project.org; Mon, 24 Nov 2008 20:39:02 +0300
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

This is a multi-part message in MIME format.
--------------050802050603060206000908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	I submitted an issue with alsa-driver 1.0.18rc3 (see 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4229). Raymond 
advised me to send the patch, so everybody with the same motherboard 
could get automatic recognition of sound card model. And here it is.

	I just don't know if I got it right. Are the hexadecimal values ok?

SND_PCI_QUIRK(0x1462, 0x7260, "MSI 7260", ALC883_TARGA_DIG),

I got this from alsainfo:

!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x14627260
Revision Id: 0x100002
No Modem Function Group found

So, I guess 0x1462 0x7260 is ok, right? If that is so, I have attached 
the diff with this message.

	Cheers,
	Strahinya

-- 
   _     _   ______________________________________________________
  /(_____)\ | ____ __  __ __ __                                    |
  \_/~ ~\_/ |/ __// /_/ // // /  http://www.gnu.org/home.sr.html   |
   (\'_'/)  / /  / __  /_\ ' /  http://www.stallman.org            |
    (o_o)  /_/  /_/ /_//____/  http://alas.matf.bg.ac.yu/~mr99164  |
            |______________________________________________________|

--------------050802050603060206000908
Content-Type: text/plain;
 name="alsa-driver-MS-7260.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="alsa-driver-MS-7260.diff"

LS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJMjAwOC0wOS0wOSAxODo1NToy
NS4wMDAwMDAwMDAgKzAyMDAKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJ
MjAwOC0xMS0yNCAxNzo1NjozMS4wMDAwMDAwMDAgKzAxMDAKQEAgLTgzMjAsNiArODMyMCw3
IEBACiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4MzcyOSwgIk1TSSBTNDIwIiwgQUxDODgz
X1RBUkdBX0RJRyksCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4Mzc4MywgIk5FQyBTOTcw
IiwgQUxDODgzX1RBUkdBX0RJRyksCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4M2I3Ziwg
Ik1TSSIsIEFMQzg4M19UQVJHQV8yY2hfRElHKSwKKwlTTkRfUENJX1FVSVJLKDB4MTQ2Miwg
MHg3MjYwLCAiTVNJIDcyNjAiLCBBTEM4ODNfVEFSR0FfRElHKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTQ2MiwgMHgzZWY5LCAiTVNJIiwgQUxDODgzX1RBUkdBX0RJRyksCiAJU05EX1BDSV9R
VUlSSygweDE0NjIsIDB4M2ZjMSwgIk1TSSIsIEFMQzg4M19UQVJHQV9ESUcpLAogCVNORF9Q
Q0lfUVVJUksoMHgxNDYyLCAweDNmYzMsICJNU0kiLCBBTEM4ODNfVEFSR0FfRElHKSwK
--------------050802050603060206000908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050802050603060206000908--
