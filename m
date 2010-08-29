From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Turtle Beach Tahiti (snd-msnd-classic)
Date: Sun, 29 Aug 2010 16:23:00 +0200
Message-ID: <F5D2EA2BCBDF9247A489B479BEB484B60B02A45910@sicily.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F5D2EA2BCBDF9247A489B479BEB484B60B02A45910sicilynmmuacz_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.nmmu.ac.za (ra.nmmu.ac.za [192.96.15.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 403572413B
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 16:22:36 +0200 (CEST)
Content-Language: en-ZA
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "krzysztof.h1@wp.pl" <krzysztof.h1@wp.pl>, "anabellesgarden@yahoo.de" <anabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

--_002_F5D2EA2BCBDF9247A489B479BEB484B60B02A45910sicilynmmuacz_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear Takashi Iwai, Krzysztof Helt, Karsten Wiese and all,

Following advice given on the bugtracker, and noting the call "testers want=
ed" in the Turtle Beach section of the ALSA soundcard matrix: I have been u=
nable to get my Tahiti soundcard working under ALSA (see issue # 5118).

Loading the ALSA driver for a Turtle Beach Tahiti fails quietly, with the f=
ollowing anomalies:
1. dmesg says "Assuming PnP mode", despite isapnp=3D0 option
2. dmesg makes no further mention of the driver (resource assignment, firmw=
are upload, DSP reset, attach?).
3. /proc/interrupts, /proc/ioports and /proc/iomem show no resource assignm=
ents
4. aplay -l lists no soundcards
5. YET: lsmod shows driver has been loaded.

Most importantly, no sound.

To reproduce:
>From Win98SE, soundcard working 100%, having noted resource allocation:
1. Reboot (dual boot) via Grub into Ubuntu 10.4 (Lucid).
2. Invoke a terminal.
3. Type: sudo modprobe snd-msnd-classic isapnp=3D0 io=3D0x3e0 irq=3D10 mem=
=3D0xd0000

Also tried:
1. Add to end of /etc/modules: snd-msnd-classic
2. Create /etc/modprobe.d/alsa_local.conf, containing:
     options snd slots=3Dsnd-msnd-classic
     alias snd-card-0 snd-msnd-classic
     options snd-msnd-classic isapnp=3D0 io=3D0x3e0 irq=3D10 mem=3D0xd0000
3. Ensure availability of msndinit.bin and msndperm.bin in /lib/firmware/tu=
rtlebeach
4. Reboot.

I have had this particular card working under SuSe (a number of years ago, =
and using the OSS driver), but I have had little success with the OSS drive=
r this time around - dmesg shows successful resource allocation, firmware u=
pload and reset, but no sound. The card remains functional under Windows, t=
hough.

Please find output of alsa-info.sh script attached.  I'm happy to assist in=
 any way I can to see this device supported.

Kind regards,
Mark Brand.



NOTICE: Please note that this eMail, and the contents thereof, is subject t=
o the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm



--_002_F5D2EA2BCBDF9247A489B479BEB484B60B02A45910sicilynmmuacz_
Content-Type: application/octet-stream; name="alsa-info.txt.ncYz0X7avn"
Content-Description: alsa-info.txt.ncYz0X7avn
Content-Disposition: attachment; filename="alsa-info.txt.ncYz0X7avn";
	size=2739; creation-date="Sun, 29 Aug 2010 16:16:23 GMT";
	modification-date="Sun, 29 Aug 2010 16:16:23 GMT"
Content-Transfer-Encoding: base64

dXBsb2FkPXRydWUmc2NyaXB0PXRydWUmY2FyZGluZm89CiEhIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKISFBTFNBIEluZm9ybWF0aW9uIFNjcmlwdCB2IDAuNC41OQohISMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCgohIVNjcmlwdCByYW4gb246IFN1biBBdWcgMjkgMTQ6
MDg6MDUgVVRDIDIwMTAKCgohIUxpbnV4IERpc3RyaWJ1dGlvbgohIS0tLS0tLS0tLS0tLS0tLS0t
LQoKVWJ1bnR1IDEwLjA0LjEgTFRTIFxuIFxsIERJU1RSSUJfSUQ9VWJ1bnR1IERJU1RSSUJfREVT
Q1JJUFRJT049IlVidW50dSAxMC4wNC4xIExUUyIKCgohIURNSSBJbmZvcm1hdGlvbgohIS0tLS0t
LS0tLS0tLS0tLQoKTWFudWZhY3R1cmVyOiAgICAgIEFtZXJpY2FuIE1lZ2F0cmVuZHMgSW5jLgpQ
cm9kdWN0IE5hbWU6ICAgICAgVklBNjk0WC82ODZBCgoKISFLZXJuZWwgSW5mb3JtYXRpb24KISEt
LS0tLS0tLS0tLS0tLS0tLS0KCktlcm5lbCByZWxlYXNlOiAgICAyLjYuMzItMjQtZ2VuZXJpYwpP
cGVyYXRpbmcgU3lzdGVtOiAgR05VL0xpbnV4CkFyY2hpdGVjdHVyZTogICAgICBpNjg2ClByb2Nl
c3NvcjogICAgICAgICB1bmtub3duClNNUCBFbmFibGVkOiAgICAgICBZZXMKCgohIUFMU0EgVmVy
c2lvbgohIS0tLS0tLS0tLS0tLQoKRHJpdmVyIHZlcnNpb246ICAgICAxLjAuMjEKTGlicmFyeSB2
ZXJzaW9uOiAgICAxLjAuMjIKVXRpbGl0aWVzIHZlcnNpb246ICAxLjAuMjIKCgohIUxvYWRlZCBB
TFNBIG1vZHVsZXMKISEtLS0tLS0tLS0tLS0tLS0tLS0tCgoKCiEhU291bmQgU2VydmVycyBvbiB0
aGlzIHN5c3RlbQohIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KClB1bHNlYXVkaW86CiAg
ICAgIEluc3RhbGxlZCAtIFllcyAoL3Vzci9iaW4vcHVsc2VhdWRpbykKICAgICAgUnVubmluZyAt
IFllcwoKRVNvdW5kIERhZW1vbjoKICAgICAgSW5zdGFsbGVkIC0gWWVzICgvdXNyL2Jpbi9lc2Qp
CiAgICAgIFJ1bm5pbmcgLSBObwoKSmFjazoKICAgICAgSW5zdGFsbGVkIC0gWWVzICgvdXNyL2Jp
bi9qYWNrZCkKICAgICAgUnVubmluZyAtIE5vCgoKISFTb3VuZGNhcmRzIHJlY29nbmlzZWQgYnkg
QUxTQQohIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgotLS0gbm8gc291bmRjYXJkcyAt
LS0KCgohIVBDSSBTb3VuZGNhcmRzIGluc3RhbGxlZCBpbiB0aGUgc3lzdGVtCiEhLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCgoKISFBZHZhbmNlZCBpbmZvcm1hdGlvbiAt
IFBDSSBWZW5kb3IvRGV2aWNlL1N1c2JzeXN0ZW0gSUQncwohIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgoKCiEhTW9kcHJvYmUgb3B0aW9u
cyAoU291bmQgcmVsYXRlZCkKISEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKc25k
LWF0aWl4cC1tb2RlbTogaW5kZXg9LTIKc25kLWludGVsOHgwbTogaW5kZXg9LTIKc25kLXZpYTgy
eHgtbW9kZW06IGluZGV4PS0yCnNuZC11c2ItYXVkaW86IGluZGV4PS0yCnNuZC11c2ItdXMxMjJs
OiBpbmRleD0tMgpzbmQtdXNiLXVzeDJ5OiBpbmRleD0tMgpzbmQtdXNiLWNhaWFxOiBpbmRleD0t
MgpzbmQtY21pcGNpOiBtcHVfcG9ydD0weDMzMCBmbV9wb3J0PTB4Mzg4CnNuZC1wY3NwOiBpbmRl
eD0tMgpzbmQtbXNuZC1jbGFzc2ljOiBpc2FwbnA9MCBpbz0weDNlMCBpcnE9MTAgbWVtPTB4ZDAw
MDAKCgohIUxvYWRlZCBzb3VuZCBtb2R1bGUgb3B0aW9ucwohIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCgoKISFBTFNBIERldmljZSBub2RlcwohIS0tLS0tLS0tLS0tLS0tLS0tCgpjcnctcnct
LS0tKyAxIHJvb3QgYXVkaW8gMTE2LCAzIEF1ZyAyOSAxNDo0OSAvZGV2L3NuZC9zZXEKY3J3LXJ3
LS0tLSsgMSByb290IGF1ZGlvIDExNiwgMiBBdWcgMjkgMTQ6NDkgL2Rldi9zbmQvdGltZXIKCgoh
IUFwbGF5L0FyZWNvcmQgb3V0cHV0CiEhLS0tLS0tLS0tLS0tCgpBUExBWQoKYXBsYXk6IGRldmlj
ZV9saXN0OjIyMzogbm8gc291bmRjYXJkcyBmb3VuZC4uLgoKQVJFQ09SRAoKYXJlY29yZDogZGV2
aWNlX2xpc3Q6MjIzOiBubyBzb3VuZGNhcmRzIGZvdW5kLi4uCgohIUFtaXhlciBvdXRwdXQKISEt
LS0tLS0tLS0tLS0tCgoKISFBbHNhY3RsIG91dHB1dAohIS0tLS0tLS0tLS0tLS0KCi0tc3RhcnRj
b2xsYXBzZS0tCi0tZW5kY29sbGFwc2UtLQoKCiEhQWxsIExvYWRlZCBNb2R1bGVzCiEhLS0tLS0t
LS0tLS0tLS0tLS0tCgpNb2R1bGUKYmluZm10X21pc2MKc25kX21zbmRfY2xhc3NpYwpzbmRfbXNu
ZF9saWIKc25kX21wdTQwMV91YXJ0CnNuZF9wY21fb3NzCnNuZF9taXhlcl9vc3MKc25kX3BjbQpz
bmRfc2VxX2R1bW15CnNuZF9zZXFfb3NzCnNuZF9zZXFfbWlkaQpzbmRfcmF3bWlkaQpzbmRfc2Vx
X21pZGlfZXZlbnQKc25kX3NlcQpzbmRfdGltZXIKZmJjb24Kc25kX3NlcV9kZXZpY2UKdGlsZWJs
aXQKZm9udApzbmQKYml0YmxpdApzb3VuZGNvcmUKc29mdGN1cnNvcgpwc21vdXNlCm52aWRpYQp2
aWFfYWdwCnZnYTE2ZmIKdmlhNjg2YQppMmNfdmlhcHJvCnZnYXN0YXRlCnNlcmlvX3JhdwpzbmRf
cGFnZV9hbGxvYwphZ3BnYXJ0CnBwZGV2CnNocGNocApwYXJwb3J0X3BjCmpveWRldgpscApwYXJw
b3J0CmhpZF9sb2dpdGVjaApmZl9tZW1sZXNzCjgxMzl0b28KdXNiaGlkCmhpZApmbG9wcHkKODEz
OWNwCnBhdGFfdmlhCm1paQoKCiEhQUxTQS9IREEgZG1lc2cKISEtLS0tLS0tLS0tLS0tLS0tLS0K
CgoK

--_002_F5D2EA2BCBDF9247A489B479BEB484B60B02A45910sicilynmmuacz_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_F5D2EA2BCBDF9247A489B479BEB484B60B02A45910sicilynmmuacz_--
