From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: nForce2 (intel8x0) playback doesn't accept 44khz
Date: Wed, 14 Jan 2004 13:27:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1rl7zlqq1sf88@mail.broadpark.no>
References: <opr1rj39qxq1sf88@mail.broadpark.no> <s5heku268bi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5heku268bi.wl@alsa2.suse.de>
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

I'm sorry i wasn't being more specific, but from browsing the archive=20
(http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg10257.ht=
ml)=20
I got the impression the rate of intel8x0 has been recently fixed at=20
48khz? Anyway, this is an Asus A7N8X Deluxe with nForce2 SoundStorm=20
onboard audio. ALSA-lib is v1.0.1, while ALSA-driver is compiled into=20
kernel 2.6.1-mm2 (v1.0.1?). The problem is consistent across programs it=20
seems, specifically my own code and aplay (sets rate to 48000 if I open=20
hw).

Regards

Arve Knudsen

On Wed, 14 Jan 2004 13:09:05 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 14 Jan 2004 12:41:59 +0100,
> Arve Knudsen wrote:
>>
>> Hello
>>
>> Has the intel8x0 driver been made accept only 48khz for playback? I=20
>> always
>> used 44.1, and wouldn't mind continuing to do so. Also, it really=20
>> baffled
>> me at first that it would accept 44.1 for capture, but not playback.=20
>> Would
>> someone care to explain, if this is how its meant to work?
>
> it depends on ac97 codec.  if the codec chip accepts the other rates,
> the intel8x0 driver accepts them, too.
>
> but for debugging, i need to know more basic info such as the version
> you're using, which codec chips, which program doesn't work, etc...
>
>
> Takashi




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
