From: Tommy Schultz Lassen <tommy@tlassen.dk>
Subject: Problems with Extigy mixer settings.
Date: Wed, 03 Mar 2004 20:59:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078343986.6219.23.camel@Fizban>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eU2v7ViUy5Uup3fLwwp8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-eU2v7ViUy5Uup3fLwwp8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

I have been having som problems with mixer settings on my Sound Blaster
Extigy. 

I am using the alsa from the linux 2.6.3 kernel. White alsa's usbaudio. 

When starting it wood fail. When i set #define IGNORE_CTL_ERROR in
usbmixer.c it wood load but when alsamixer came to the settings for the
digital In mixer port it wood start printing errors to the console.

This patch fixes it by disabling the mixer channel which gave the
problems.

Tommy

--=-eU2v7ViUy5Uup3fLwwp8
Content-Disposition: attachment; filename=extigy.patch
Content-Type: text/x-patch; name=extigy.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4zL3NvdW5kL3VzYi91c2JtaXhlcl9tYXBzLmMJMjAwNC0wMi0yNSAxODoy
MjoxMC4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYuMy11c2JhdWRpby9zb3VuZC91c2Iv
dXNibWl4ZXJfbWFwcy5jCTIwMDQtMDItMjYgMjE6MzI6NTQuMDAwMDAwMDAwICswMTAwDQpAQCAt
ODYsNiArODYsNyBAQA0KIAl7IDI2LCAiSUVDOTU4IE9wdGljYWwgUGxheWJhY2siIH0sIC8qIE9U
ICovDQogCXsgMjcsIE5VTEwgfSwgLyogRElTQUJMRUQ6IEVVIChmb3Igd2hhdD8pICovDQogCS8q
IDI4OiBGVSBzcGVha2VyIChtdXRlKSAqLw0KKwl7IDI5LCBOVUxMIC8qIkRpZ2l0YWwgSW4gUGxh
eWJhY2sgU291cmNlIiovfSwgLyogKi8NCiAJeyAwIH0gLyogdGVybWluYXRvciAqLw0KIH07DQog
DQo=

--=-eU2v7ViUy5Uup3fLwwp8--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
