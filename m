From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: PCM format restrict dilema
Date: Tue, 16 Sep 2003 10:19:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063721993.1556.12.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I have the following dilema. The Aureal Vortex DMA engine supports
upto 4 hardware pages, but they have to be frame aligned. The current
driver also needs them to be of the same size. To archive this, i added
the following code in the pcm "open" function.

/* Force equal size periods */
if ((err = snd_pcm_hw_constraint_integer(runtime,
SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
return err;
/* Force DMA 32 bit alignment */
if ((err = snd_pcm_hw_constraint_step(runtime, 0,
SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4)) < 0)
return err;

Now PCM works correctly, but some apps, like aplay fail to play some
formats, because they get their period size requirementes rejected, and
they just give up instead of trying other period sizes. Since aplay uses
a time based criteria for the period sizes instead of "sane" values, the
period sizes are very odd.

The question is, should i blame aplay or try to implement some
workaround in the Aureal driver ??

Best Regards.

Manuel Jander



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
