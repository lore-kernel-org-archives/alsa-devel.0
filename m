From: "Sebastian Vieira" <svieira75@hotmail.com>
Subject: Audigy 2 NX / Extigy sound fix
Date: Sat, 18 Dec 2004 10:57:41 +0000
Message-ID: <BAY22-F29C510BBA2495E1FAE00AEBEA00@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_70cf_75c7_6f81"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

This is a multi-part message in MIME format.

------=_NextPart_000_70cf_75c7_6f81
Content-Type: text/plain; format=flowed

Hi there,

This is my first message to the alsa mailing list. I hope this is the right 
place where to post fixes.

It seems that the external sound card Audigy 2 NX / Extigy presents the same 
problems than the little brother usb 1 model. There is a quick fix for this 
by forcing a sample rate of 48k. That fix is already present for the small 
brother. Just modifying it a little to recognise the new one is enough to 
have it in place.

The patch has to be done on the alsa-kernel module (usb/usbaudio.c)

The modified code starts at line 2412 and it reads:

#if 1
/* FIXME: temporary hack for extigy */
/* extigy and extigy 2 (usb1 and usb2) apparently supports sample rates 
other than 48k
  * but not in ordinary way.  so we enable only 48k atm.
  */
if (dev->descriptor.idVendor == 0x041e && (dev->descriptor.idProduct == 
0x3000) || (dev->descriptor.idProduct == 0x3020)) {
  if ( (stream == SNDRV_PCM_STREAM_PLAYBACK) &&
       (fp->rates != SNDRV_PCM_RATE_48000) )
   return -1; /* use 48k only */
}
#endif

I submit a patch to apply against the sourcecode for better integration.

And of course, if this is not the place to submit patches, please tell me 
where. I was unnable to find any! :-)

Regards,

Sebastian Vieira.


------=_NextPart_000_70cf_75c7_6f81
Content-Type: application/octet-stream; name="patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.diff"

PyBwYXRjaC5kaWZmCkluZGV4OiB1c2IvdXNiYXVkaW8uYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9hbHNhL2Fsc2Eta2Vy
bmVsL3VzYi91c2JhdWRpby5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEx
MwpkaWZmIC11IC1yMS4xMTMgdXNiYXVkaW8uYwotLS0gdXNiL3VzYmF1ZGlv
LmMJMTYgRGVjIDIwMDQgMTY6MTI6NTEgLTAwMDAJMS4xMTMKKysrIHVzYi91
c2JhdWRpby5jCTE4IERlYyAyMDA0IDEwOjI5OjQ0IC0wMDAwCkBAIC0yNDEy
LDE2ICsyNDEyLDE1IEBACiAJaWYgKGVyciA8IDApCiAJCXJldHVybiBlcnI7
CiAjaWYgMQotCS8qIEZJWE1FOiB0ZW1wb3JhcnkgaGFjayBmb3IgZXh0aWd5
ICovCi0JLyogZXh0aWd5IGFwcGFyZW50bHkgc3VwcG9ydHMgc2FtcGxlIHJh
dGVzIG90aGVyIHRoYW4gNDhrCi0JICogYnV0IG5vdCBpbiBvcmRpbmFyeSB3
YXkuICBzbyB3ZSBlbmFibGUgb25seSA0OGsgYXRtLgotCSAqLwotCWlmIChk
ZXYtPmRlc2NyaXB0b3IuaWRWZW5kb3IgPT0gMHgwNDFlICYmIGRldi0+ZGVz
Y3JpcHRvci5pZFByb2R1Y3QgPT0gMHgzMDAwKSB7Ci0JCWlmIChmbXRbM10g
PT0gVVNCX0ZPUk1BVF9UWVBFX0kgJiYKLQkJICAgIHN0cmVhbSA9PSBTTkRS
Vl9QQ01fU1RSRUFNX1BMQVlCQUNLICYmCi0JCSAgICBmcC0+cmF0ZXMgIT0g
U05EUlZfUENNX1JBVEVfNDgwMDApCi0JCQlyZXR1cm4gLTE7IC8qIHVzZSA0
OGsgb25seSAqLwotCX0KKyAvKiBGSVhNRTogdGVtcG9yYXJ5IGhhY2sgZm9y
IGV4dGlneSAqLworIC8qIGV4dGlneSBhbmQgZXh0aWd5IDIgKHVzYjEgYW5k
IHVzYjIpIGFwcGFyZW50bHkgc3VwcG9ydHMgc2FtcGxlIHJhdGVzIG90aGVy
IHRoYW4gNDhrCisgICogYnV0IG5vdCBpbiBvcmRpbmFyeSB3YXkuICBzbyB3
ZSBlbmFibGUgb25seSA0OGsgYXRtLgorICAqLworIGlmIChkZXYtPmRlc2Ny
aXB0b3IuaWRWZW5kb3IgPT0gMHgwNDFlICYmIChkZXYtPmRlc2NyaXB0b3Iu
aWRQcm9kdWN0ID09IDB4MzAwMCkgfHwgKGRldi0+ZGVzY3JpcHRvci5pZFBy
b2R1Y3QgPT0gMHgzMDIwKSkgeworICBpZiAoIChzdHJlYW0gPT0gU05EUlZf
UENNX1NUUkVBTV9QTEFZQkFDSykgJiYKKyAgICAgICAoZnAtPnJhdGVzICE9
IFNORFJWX1BDTV9SQVRFXzQ4MDAwKSApCisgICByZXR1cm4gLTE7IC8qIHVz
ZSA0OGsgb25seSAqLworIH0KICNlbmRpZgogCXJldHVybiAwOwogfQo=


------=_NextPart_000_70cf_75c7_6f81--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
