From: "Tehn Yit Chin" <tehn.yit.chin@gmail.com>
Subject: Power management questions...
Date: Wed, 8 Mar 2006 14:55:55 +1100
Message-ID: <bf04f99c0603071955i5f7517aaw5aeb16bd0a7e26c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2122_10340639.1141790155808"
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

------=_Part_2122_10340639.1141790155808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

1) suspending/resuming
I am putting some power managment coding into my alsa driver. When I want t=
o
suspend, I inform ALSA via the following two calls.

snd_pcm_suspend_all(card->pcm);
snd_power_change_state(card->card, SNDRV_CTL_POWER_D3cold);

When I am doing a resume, I would have assumed that they is an equivalent t=
o
snd_pcm_suspend_all(), but all I could find  snd_pcmd_resume() which is
usually OK, but this is declared as a static as in

static int snd_pcm_resume(snd_pcm_substream_t *substream)

At the moment, all I am doing when I am resuming is to call

snd_power_change_state(card->card, SNDRV_CTL_POWER_D0);

This seems to be working, but I think that I am doing the wrong thing.

2) SND_PCM_TRIGGER_SUSPEND and SND_PCM_TRIGGER_RESUME
If I follow the call tree down for snd_pcm_suspend_call(), it calls a
trigger callback with a command of SND_PCM_TRIGGER_SUSPEND. A similiar thin=
g
occurs for resume where the trigger callback is called with the command of
SND_PCM_TRIGGER_RESUME. Should I handling these two commands in my trigger
callback and manage the DMA transfer accordingly?

any pointers is appreciated.

thanks,
Tehn Yit Chin

------=_Part_2122_10340639.1141790155808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br><br>1) suspending/resuming<br>I am putting some power managment =
coding into my alsa driver. When I want to suspend, I inform ALSA via the f=
ollowing two calls.<br><br>snd_pcm_suspend_all(card-&gt;pcm);<br>snd_power_=
change_state(card-&gt;card, SNDRV_CTL_POWER_D3cold);
<br><br>When I am doing a resume, I would have assumed that they is an equi=
valent to snd_pcm_suspend_all(), but all I could find&nbsp; snd_pcmd_resume=
() which is usually OK, but this is declared as a static as in<br><br>stati=
c int snd_pcm_resume(snd_pcm_substream_t *substream)
<br><br>At the moment, all I am doing when I am resuming is to call<br><br>=
snd_power_change_state(card-&gt;card, SNDRV_CTL_POWER_D0);<br><br>This seem=
s to be working, but I think that I am doing the wrong thing.<br><br>2) SND=
_PCM_TRIGGER_SUSPEND and SND_PCM_TRIGGER_RESUME
<br>If I follow the call tree down for snd_pcm_suspend_call(), it calls a t=
rigger callback with a command of SND_PCM_TRIGGER_SUSPEND. A similiar thing=
 occurs for resume where the trigger callback is called with the command of=
 SND_PCM_TRIGGER_RESUME. Should I handling these two commands in my trigger=
 callback and manage the DMA transfer accordingly?
<br><br>any pointers is appreciated.<br><br>thanks,<br>Tehn Yit Chin<br>

------=_Part_2122_10340639.1141790155808--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
