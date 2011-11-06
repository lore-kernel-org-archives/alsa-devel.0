From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Sun, 6 Nov 2011 19:46:01 +0800
Message-ID: <CAN8cciaiRi79gKXe4MyYPosqA9Tv-fwkSSzG3Uouk3ocJUVa8w@mail.gmail.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
	<CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
	<4EB05EA1.1060701@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174be34e7d339904b10f7b18
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B39822415A
	for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2011 12:46:01 +0100 (CET)
Received: by faao24 with SMTP id o24so4580274faa.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Nov 2011 03:46:01 -0800 (PST)
In-Reply-To: <4EB05EA1.1060701@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, akashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--0015174be34e7d339904b10f7b18
Content-Type: text/plain; charset=ISO-8859-1

2011/11/2 David Henningsson <david.henningsson@canonical.com>:
> 2011-10-24 23:31, Raymond Yau skrev:
>>
> I also think it is a good idea, in fact I thought it was this way already.
> Can we merge this patch?
>
> // David
>

commit	729d55ba972348234759f8e40abf8de020f0d505

ALSA: hda - Disable tigger at pin-sensing on AD codecs


It is possible to measure the impedance of the jack with modification
of hda-jack-sense-test.py with ad1988

The headphone was plugged into grey jack since my computer chassis
only have AC97 front audio panel

The result seem close to my headset specification


Pin 0x11 Green HP Out (Ext Front): No jack detect capability
Pin 0x12 Green Line Out (Ext Rear): present = YES   impedance = 3776
Pin 0x14 Pink Mic (Ext Front): No jack detect capability
Pin 0x15 Blue Line In (Ext Rear): present = No
Pin 0x16 Black Line Out (Ext Rear): present = YES   impedance = 6080
Pin 0x17 Pink Mic (Ext Rear): present = YES   impedance = 1008
Pin 0x18 Black CD (Int ATAPI): No jack detect capability
Pin 0x1a Other (Int ATAPI): No jack detect capability
Pin 0x1b Other SPDIF Out (Ext Rear): No jack detect capability
Pin 0x24 Orange Line Out (Ext Rear): present = No
Pin 0x25 Grey Line Out (Ext Rear): present = YES   impedance = 25

--0015174be34e7d339904b10f7b18
Content-Type: application/octet-stream; name="hda-jack-sense-test.py"
Content-Disposition: attachment; filename="hda-jack-sense-test.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gunz3n3z0

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uCiMKIyBXcml0dGVuIGJ5IERhdmlkIEhlbm5pbmdzc29uLCBD
b3B5cmlnaHQgMjAxMSBDYW5vbmljYWwgTHRkLiAKIyBMaWNlbnNlZCB1bmRlciBHUEx2MisKCiMg
dGhlIGhkYV9jb2RlYy5weSBmaWxlIGNvbWVzIGZyb20gSmFyb3NsYXYgS3lzZWxhJ3MgaGRhX2Fu
YWx5emVyIHByb2dyYW0uCmZyb20gaGRhX2NvZGVjIGltcG9ydCAqCmltcG9ydCB0aW1lCgpkZWYg
cGFyc2VvcHRpb25zKCk6CiAgICBmcm9tIG9wdHBhcnNlIGltcG9ydCBPcHRpb25QYXJzZXIKICAg
IHBhcnNlciA9IE9wdGlvblBhcnNlcigpCiAgICBwYXJzZXIuYWRkX29wdGlvbigiLWMiLCAiLS1j
YXJkIiwgZGVzdD0iY2FyZGluZGV4IiwgZGVmYXVsdD0wLCBtZXRhdmFyPSJDQVJEIiwKICAgICAg
ICBoZWxwPSJjYXJkIGluZGV4IChhcyBjYW4gYmUgc2VlbiBpbiAvcHJvYy9hc291bmQvY2FyZHMp
IikKICAgIHBhcnNlci5hZGRfb3B0aW9uKCItaSIsICItLWNvZGVjIiwgZGVzdD0iY29kZWNpbmRl
eCIsIGRlZmF1bHQ9MCwgbWV0YXZhcj0iQ09ERUMiLAogICAgICAgIGhlbHA9ImNvZGVjIGluZGV4
IChhcyBjYW4gYmUgc2VlbiBpbiAvcHJvYy9hc291bmQvY2FyZFgvY29kZWNZKSIpCiAgICAob3B0
aW9ucywgYXJncykgPSBwYXJzZXIucGFyc2VfYXJncygpCiAgICByZXR1cm4gaW50KG9wdGlvbnMu
Y2FyZGluZGV4KSwgaW50KG9wdGlvbnMuY29kZWNpbmRleCkKICAgIApkZWYgZ2V0X3NpbXBsZWNh
cHMobm9kZSk6CiAgICBpZiBub2RlLmphY2tfY29sb3JfbmFtZSA9PSAnVW5rbm93bic6CiAgICAg
ICAgcmV0dXJuICIlcyAoJXMgJXMpIiAlIChub2RlLmphY2tfdHlwZV9uYW1lLCBub2RlLmphY2tf
bG9jYXRpb25fbmFtZSwgbm9kZS5qYWNrX2xvY2F0aW9uMl9uYW1lKQogICAgcmV0dXJuICIlcyAl
cyAoJXMgJXMpIiAlIChub2RlLmphY2tfY29sb3JfbmFtZSwgbm9kZS5qYWNrX3R5cGVfbmFtZSwg
bm9kZS5qYWNrX2xvY2F0aW9uX25hbWUsIG5vZGUuamFja19sb2NhdGlvbjJfbmFtZSkKCmNhcmRp
bmRleCwgY29kZWNpbmRleCA9IHBhcnNlb3B0aW9ucygpCmNvZGVjID0gSERBQ29kZWMoY2FyZGlu
ZGV4LCBjb2RlY2luZGV4KQpjb2RlYy5hbmFseXplKCkKZm9yIG5pZCBpbiBjb2RlYy5ub2RlczoK
ICAgIG5vZGUgPSBjb2RlYy5nZXRfbm9kZShuaWQpCiAgICBpZiBXSURHRVRfVFlQRV9JRFNbbm9k
ZS53dHlwZV0gPT0gJ1BJTic6CiAgICAgICAgaWYgKChub2RlLmRlZmNmZ19waW5jYXBzID4+IDMw
KSAmIDB4MDMpICE9IDE6CgkgICAgaWYgKG5vZGUucGluY2FwcyAmIDEpOgogICAgICAgICAgICAg
ICAgY29kZWMucncobmlkLCBWRVJCU1snU0VUX1BJTl9TRU5TRSddLCAwKQogICAgICAgICAgICAg
ICAgdGltZS5zbGVlcCgwLjAxKQogICAgICAgICAgICBzZW5zZSA9IGNvZGVjLnJ3KG5pZCwgVkVS
QlNbJ0dFVF9QSU5fU0VOU0UnXSwgMCkKICAgICAgICAgICAgaWYgbm9kZS5kZWZjZmdfcGluY2Fw
cyAmICgxIDw8IDgpOgogICAgICAgICAgICAgICAgcHJpbnQgIlBpbiAweCUuMnggJXM6IE5vIGph
Y2sgZGV0ZWN0IGNhcGFiaWxpdHkiICUgKG5pZCwgZ2V0X3NpbXBsZWNhcHMobm9kZSkpCiAgICAg
ICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICBpZiBzZW5zZSAmIDB4ODAwMDAwMDA6CiAgICAg
ICAgICAgICAgICAgICAgcHJpbnQgIlBpbiAweCUuMnggJXM6IHByZXNlbnQgPSBZRVMgICBpbXBl
ZGFuY2UgPSAlZCIgJSAobmlkLCBnZXRfc2ltcGxlY2Fwcyhub2RlKSwgc2Vuc2UgLSAweDgwMDAw
MDAwKQogICAgICAgICAgICAgICAgZWxzZToKICAgICAgICAgICAgICAgICAgICBwcmludCAiUGlu
IDB4JS4yeCAlczogcHJlc2VudCA9IE5vIiAlIChuaWQsIGdldF9zaW1wbGVjYXBzKG5vZGUpKQo=
--0015174be34e7d339904b10f7b18
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015174be34e7d339904b10f7b18--
