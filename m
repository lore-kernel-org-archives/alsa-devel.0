From: alsa@0x00.my-ho.st
Subject: Re: Maestro 2E (rev 10) not found or device busy w/
 0.9.2
Date: Tue, 8 Apr 2003 12:15:42 -0600 (MDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0304081112590.0@0x00.my-ho.st>
References: <Pine.LNX.4.50.0303261659330.8112-100000@0x00.my-ho.st>
 <s5hof3xnp8c.wl@alsa2.suse.de> <Pine.LNX.4.50.0303271039120.8112-100000@0x00.my-ho.st>
 <0304061234440.0@0x00.my-ho.st> <s5histpq7z0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655872-853909160-1049825475=:5382"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5histpq7z0.wl@alsa2.suse.de>
Content-ID: <0304081211520.138129129@0x00.my-ho.st>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655872-853909160-1049825475=:5382
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <0304081211521.959590713@0x00.my-ho.st>

On Tue, 8 Apr 2003, Takashi Iwai wrote:

> At Sun, 6 Apr 2003 12:55:56 -0600 (MDT),
> alsa@0x00.my-ho.st wrote:
> >
> > On Thu, 27 Mar 2003 alsa@0x00.my-ho.st wrote:
> >
> > > On Thu, 27 Mar 2003, Takashi Iwai wrote:
> > >
> > > > At Wed, 26 Mar 2003 17:12:55 -0700 (MST),
> > > > alsa@0x00.my-ho.st wrote:
> > > > >
> > > > > The 'maestro' driver included with Linux 2.4.x loads, and for the most
> > > > > part works okay.  However trying to use the latest ALSA results in:
> > > > >
> > > > > kernel: es1968: not attempting power management.
> > > > > kernel: ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1960: AC'97 0:0 does not respond - RESET
> > > > > kernel: ESS Maestro soundcard not found or device busy
> > > > >
> > > > > Anyone have any suggestions on how to fix this?
> > > >
> > > > which version of alsa did you test exactly?
> > > > i thought this was fixed in the recent version.  please try the cvs
> > > > version if not tried yet.
> > >
> > > Thanks for the quick response.  I have tried 0.9.2 and the latest cvs;
> > > both give the same errors.  :(
> > >
> > > Any suggestions?
> >
> > Since I didn't get any response yet I decided to look into this more
> > closely myself.
> >
> > The problem appears to be that although 0x8a05 is written to the
> > AC97_REC_GAIN register, a subsequent read returns 0xa05.  Anyone know why
> > this might occur?  Could someone more familiar with the ALSA code give me
> > some pointers on where to go from here?
>
> it seems that the codec is not 100% compliant to the ac97 spec.
> which ac97 codec is on yours?

$ cat /proc/asound/card0/ac97\#0
0-0/0: SigmaTel STAC9721/23

>  (you can proceed the process there by
> replacing 0x8a05 to 0x0a05...)

This change allows the driver to load, but:

$ aumix
aumix:  no device found

$ alsamixer
No mixer elems found

> also, please give the detail of your hardware (the product name and
> the output of lspci -nv).

It's a Compaq Armada E500 laptop.  Output from 'lspci -nv' attached.

Thanks for the reply!  Any suggestions where to go from here?

  - Ted
--655872-853909160-1049825475=:5382
Content-Type: TEXT/PLAIN; NAME="lspci-e500.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <0304081211150.143838536@0x00.my-ho.st>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="lspci-e500.txt"

MDA6MDAuMCBDbGFzcyAwNjAwOiA4MDg2OjcxOTAgKHJldiAwMykNCglTdWJz
eXN0ZW06IDBlMTE6YjExMA0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0g
ZGV2c2VsLCBsYXRlbmN5IDY0DQoJTWVtb3J5IGF0IDUwMDAwMDAwICgzMi1i
aXQsIHByZWZldGNoYWJsZSkgW3NpemU9NjRNXQ0KCUNhcGFiaWxpdGllczog
W2EwXSBBR1AgdmVyc2lvbiAxLjANCg0KMDA6MDEuMCBDbGFzcyAwNjA0OiA4
MDg2OjcxOTEgKHJldiAwMykNCglGbGFnczogNjZNaHosIG1lZGl1bSBkZXZz
ZWwNCglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMSwgc3Vib3JkaW5h
dGU9MDEsIHNlYy1sYXRlbmN5PTANCglJL08gYmVoaW5kIGJyaWRnZTogMDAw
MDIwMDAtMDAwMDJmZmYNCglNZW1vcnkgYmVoaW5kIGJyaWRnZTogNDAwMDAw
MDAtNDEwZmZmZmYNCg0KMDA6MDQuMCBDbGFzcyAwNjA3OiAxMDRjOmFjMWMg
KHJldiAwMSkNCglTdWJzeXN0ZW06IDBlMTE6YjEyMQ0KCUZsYWdzOiBidXMg
bWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDE2OCwgSVJRIDExDQoJ
TWVtb3J5IGF0IDQxMTAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUp
IFtzaXplPTRLXQ0KCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAyLCBz
dWJvcmRpbmF0ZT0wMiwgc2VjLWxhdGVuY3k9MTc2DQoJTWVtb3J5IHdpbmRv
dyAwOiAxMDAwMDAwMC0xMDNmZjAwMCAocHJlZmV0Y2hhYmxlKQ0KCU1lbW9y
eSB3aW5kb3cgMTogMTA0MDAwMDAtMTA3ZmYwMDANCglJL08gd2luZG93IDA6
IDAwMDA0NDAwLTAwMDA0NGZmDQoJSS9PIHdpbmRvdyAxOiAwMDAwNDgwMC0w
MDAwNDhmZg0KCTE2LWJpdCBsZWdhY3kgaW50ZXJmYWNlIHBvcnRzIGF0IDAw
MDENCg0KMDA6MDQuMSBDbGFzcyAwNjA3OiAxMDRjOmFjMWMgKHJldiAwMSkN
CglTdWJzeXN0ZW06IDBlMTE6YjEyMQ0KCUZsYWdzOiBidXMgbWFzdGVyLCBt
ZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDE2OCwgSVJRIDExDQoJTWVtb3J5IGF0
IDQxMTgwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRL
XQ0KCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAzLCBzdWJvcmRpbmF0
ZT0wMywgc2VjLWxhdGVuY3k9MTc2DQoJTWVtb3J5IHdpbmRvdyAwOiAxMDgw
MDAwMC0xMGJmZjAwMCAocHJlZmV0Y2hhYmxlKQ0KCU1lbW9yeSB3aW5kb3cg
MTogMTBjMDAwMDAtMTBmZmYwMDANCglJL08gd2luZG93IDA6IDAwMDA0YzAw
LTAwMDA0Y2ZmDQoJSS9PIHdpbmRvdyAxOiAwMDAwNTQwMC0wMDAwNTRmZg0K
CTE2LWJpdCBsZWdhY3kgaW50ZXJmYWNlIHBvcnRzIGF0IDAwMDENCg0KMDA6
MDcuMCBDbGFzcyAwNjgwOiA4MDg2OjcxMTAgKHJldiAwMikNCglGbGFnczog
YnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAwDQoNCjAwOjA3
LjEgQ2xhc3MgMDEwMTogODA4Njo3MTExIChyZXYgMDEpIChwcm9nLWlmIDgw
IFtNYXN0ZXJdKQ0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2Vs
LCBsYXRlbmN5IDY0DQoJSS9PIHBvcnRzIGF0IDM0MjAgW3NpemU9MTZdDQoN
CjAwOjA3LjIgQ2xhc3MgMGMwMzogODA4Njo3MTEyIChyZXYgMDEpDQoJRmxh
Z3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgNjQsIElS
USAxMQ0KCUkvTyBwb3J0cyBhdCAzNDAwIFtzaXplPTMyXQ0KDQowMDowNy4z
IENsYXNzIDA2ODA6IDgwODY6NzExMyAocmV2IDAzKQ0KCUZsYWdzOiBtZWRp
dW0gZGV2c2VsLCBJUlEgOQ0KDQowMDowOC4wIENsYXNzIDA0MDE6IDEyNWQ6
MTk3OCAocmV2IDEwKQ0KCVN1YnN5c3RlbTogMGUxMTpiMTEyDQoJRmxhZ3M6
IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgNjQsIElSUSAx
MQ0KCUkvTyBwb3J0cyBhdCAzMDAwIFtzaXplPTI1Nl0NCglDYXBhYmlsaXRp
ZXM6IFtjMF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCg0KMDA6MDku
MCBDbGFzcyAwMjAwOiA4MDg2OjEyMjkgKHJldiAwOSkNCglTdWJzeXN0ZW06
IDgwODY6MjIwNA0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2Vs
LCBsYXRlbmN5IDY2LCBJUlEgMTENCglNZW1vcnkgYXQgNDEyODAwMDAgKDMy
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdDQoJSS9PIHBvcnRz
IGF0IDM0NDAgW3NpemU9NjRdDQoJTWVtb3J5IGF0IDQxMjAwMDAwICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTEyOEtdDQoJRXhwYW5zaW9u
IFJPTSBhdCA8dW5hc3NpZ25lZD4gW2Rpc2FibGVkXSBbc2l6ZT0xTV0NCglD
YXBhYmlsaXRpZXM6IFtkY10gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIN
Cg0KMDA6MDkuMSBDbGFzcyAwNzAwOiAxMWMxOjA0NDUNCglTdWJzeXN0ZW06
IDgwODY6MjIwNA0KCUZsYWdzOiBtZWRpdW0gZGV2c2VsLCBJUlEgMTENCglJ
L08gcG9ydHMgYXQgMzQzMCBbc2l6ZT04XQ0KCU1lbW9yeSBhdCA0MTMwMDAw
MCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10NCglDYXBh
YmlsaXRpZXM6IFtkY10gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCg0K
MDE6MDAuMCBDbGFzcyAwMzAwOiAxMDAyOjRjNGQgKHJldiA2NCkNCglTdWJz
eXN0ZW06IDBlMTE6YjE2MA0KCUZsYWdzOiBidXMgbWFzdGVyLCBzdGVwcGlu
ZywgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSA2NiwgSVJRIDExDQoJTWVtb3J5
IGF0IDQwMDAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXpl
PTE2TV0NCglJL08gcG9ydHMgYXQgMjAwMCBbc2l6ZT0yNTZdDQoJTWVtb3J5
IGF0IDQxMDAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXpl
PTRLXQ0KCUV4cGFuc2lvbiBST00gYXQgPHVuYXNzaWduZWQ+IFtkaXNhYmxl
ZF0gW3NpemU9MTI4S10NCglDYXBhYmlsaXRpZXM6IFs1MF0gQUdQIHZlcnNp
b24gMS4wDQoJQ2FwYWJpbGl0aWVzOiBbNWNdIFBvd2VyIE1hbmFnZW1lbnQg
dmVyc2lvbiAxDQoNCg==

--655872-853909160-1049825475=:5382--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
