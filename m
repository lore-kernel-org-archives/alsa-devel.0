From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: nForce2 (intel8x0) playback doesn't accept 44khz
Date: Wed, 14 Jan 2004 14:57:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1rqddayq1sf88@mail.broadpark.no>
References: <opr1rj39qxq1sf88@mail.broadpark.no> <s5heku268bi.wl@alsa2.suse.de> <opr1rl7zlqq1sf88@mail.broadpark.no> <s5hd69m63yw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd69m63yw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Jan 2004 14:43:03 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 14 Jan 2004 13:27:25 +0100,
> Arve Knudsen wrote:
>>
>> I'm sorry i wasn't being more specific, but from browsing the archive
>> (http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg10257=
.html)
>
> no, it was a bug.
>
>> I got the impression the rate of intel8x0 has been recently fixed at
>> 48khz? Anyway, this is an Asus A7N8X Deluxe with nForce2 SoundStorm
>> onboard audio. ALSA-lib is v1.0.1, while ALSA-driver is compiled into
>> kernel 2.6.1-mm2 (v1.0.1?). The problem is consistent across programs =
it
>> seems, specifically my own code and aplay (sets rate to 48000 if I ope=
n
>> hw).
>
> as mentioned, the support sample rate is dependent on AC97 codec.
>
> check /proc/asound/card0/codec97#0/* files.
> if your codec supports VRA, you'll see it in the extended id line.
>
>
> Takashi

The thing is it used to support 44.1 just fine, its only recently there's=
=20
been a problem. Besides isn't it weird that capture will support 44.1=20
while playback doesn't? Anyhow, the extended id line indicates it support=
s=20
VRA:
Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
