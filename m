From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: iec958 regression with alsa 1.0.22 and kernel
 2.6.33 on Intel DG45FC motherboard
Date: Thu, 6 May 2010 09:42:27 +0200 (CEST)
Message-ID: <0c7a6777d7b1bd6032e87a5955efb7cd.squirrel@www.hardeman.nu>
References: <20100505230516.GA4765@hardeman.nu>
	<20100506005509.GC5335@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <20100506005509.GC5335@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 6, 2010 02:55, Wu Fengguang wrote:
> On Thu, May 06, 2010 at 07:05:16AM +0800, David H=C3=A4rdeman wrote:
>> A recent upgrade to kernel 2.6.33.x and alsa 1.0.22 broke spdif (iec958)
>
> Upgraded from which kernel?

2.6.32.something, can check exact version later if you want. alsa
userspace bits were upgraded at the same time (can also check from which
version later if necessary).

>> output on my Intel DG45FC motherboard (IDT 92HD73E1X5 codec,
>> snd-hda-intel driver).
>>
>> After playing around a bit with module params, it turns out that loading
>> snd-hda-intel with model=3Dno-jd fixes this problem (previously the modu=
le
>> worked without any model option at all, note also that model=3Dintel does
>> not work which is kinda weird).
>
> You mean model=3Dintel never worked?

No, I mean that I've never used a model=3D parameter before, and in trying
to debug this new problem I tried model=3Dintel which did not fix it but
model=3Dno-jd does. So model=3Dintel might have worked before.

On a related note, why is model=3Dintel even there (and why is the end-user
expected to set it)? The docs says it's for DG45FC and DG45ID
motherboards, but shouldn't those motherboards be possible to autodetect
in the driver via DMI info?

-- =

David H=E4rdeman


---------------------------------------------------------------------------=
---
