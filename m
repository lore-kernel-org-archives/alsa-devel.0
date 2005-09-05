From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Mo' better modem support
Date: Tue, 06 Sep 2005 02:29:51 +0300
Message-ID: <20050905232951.GG20428@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h64tfs8wm.wl%tiwai@suse.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 19:48 Mon 05 Sep     , Takashi Iwai wrote:
> 
> I've played a bit the ac97 modem yesterday,

Great!

> and found out the
> following problems:
> 
> 1. Off-Hook switch needs manually turned on

Yes. I think that it is ok, this should be controlled separately from
PCM. For instance for Caller ID polling we will need to run capturing
with CID switch 'on' and Off-Hook switch 'off'. Other example is typical
dialer (auto-dialer or so), this will turn 'Off-hook' switch 'on', start
playback (to send DTMFs), stop playback and leave line with 'Off-hook'
is 'on'.

>    Shall we add a hook in pcm.modem definition for this control?

If we really need to auto-"Hoof-Off" we may separate it to logically
different pcm devices (like pcm.modem, pcm.phoneline or so) and then add
hook to one of them.

( But really, who will use it? Specialized phone oriented application
(like dialer, voice machine or softmodem) will control DAA specific
switches explicitly anyway. And for simple scripting amixer + aplay
should be good enough. )

> 2. All controls have index 1, thus the appearance on alsamixer looks
>    strange

Will see it (no modems near me).

> 3. There is no way to detect the modem driver from sysfs or so.

There is no some "standard" way to define softmodem in Linuxi - remember
this "winmodem is not modem", and this is correct. What we actually have
in hardware (and in ALSA) is not modem, it is simplified sound codec +
Data Access Arrangement (DAA) (aka Telephone Line Interface Circuit).
And the "real" modem (which performs modulation/demodulation) is
user-space application (like proprietary 'slmodem') that uses the
standard ALSA api to communicate with this sound device.

( don't mention here binary-only kernel modem drivers provided by some
vendors. )

>    Espeically, hda-intel driver supports both audio and modem by a
>    single driver, and the modem support doesn't appear even on proc
>    file explicitly.

Agree, 'proc' files will be helpful with MFG too. Actually I've planned
to do it, but don't have HDA hardware now. Testers?

(BTW one more reason why it will be helpful: existed HDA modem driver
has just one (known) vendor ID, but I guess there will be more same chip
based modems with different vendor IDs. If we will show this info
somewhere in proc files it will simplify IDs addition)

> Well, 2 is a minor problem, and we can live with that.
> But others should be improved...
>
>
> Any ideas?

Some more things for your list:

4. Unsupported Conexant modem codecs (AC97 and HDA).
5. Lack of incoming call notifications.
6. Lack of free softmodem software.

'5' may be related to '3', but I think this is more generic problem:
is there "standard" telephony interface (or just used by nobody
'include/linux/telephony.h')?

Sasha.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
