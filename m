From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: changing audio routing through mixer controls with emu10k1/audigy
Date: Sun, 25 Sep 2005 23:46:58 +0000
Message-ID: <20050925234658.4d008c9e@VikingPC.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


Hello

I just switched from using the OSS emu10k1 driver to alsa.
However the mixer controls seem a bit screwed up, nothing new though, since the
default setup of the programmable emu10k1 chip IS a bit screwed.

Especially with a sourround setup its annoying to be unable to change the total
volume since both PCM and MASTER dont affect the rear and center speakers, so to
"just change the volume" you have to change 3 sliders - not to mention breaking
a the sensitive fine-tuning 

With the emu10k1 project came some tools, that made it possible to load sound
modificating applets into the DSP core and more important, change the routing of
audio signals from sources (input, PCM, ...) over a freely definable set those
filters and mixer controls towards output channels

for example like this

inputs		mixer		filter		mixer		mixer		output


PCM_l		PCM_l ctrl	global_tone	master_l	digital 1 l	front-left
PCM_r		PCM_r ctrl	global_tone	master_r	digital 1 r	front-right
PCM_l		PCM_l ctrl	global_tone	master_l	digital 2 l	rear-left
PCM_r		PCM_r ctrl	global_tone	master_r	digital 2 r	rear-right
PCM_l		PCM_l ctrl	global_tone	master_l	digital 3 l	center
PCM_r		PCM_r ctrl	global_tone	master_r	digital 3 r	sub
LINE_IN_l	LINE_l ctrl	global_tone	master_l	digital 1 l	front-left
LINE_IN_r	LINE_r ctrl	global_tone	master_r	digital 1 r	front-right
LINE_IN_l	LINE_l ctrl	global_tone	master_l	digital 2 l	rear-left
LINE_IN_r	LINE_r ctrl	global_tone	master_r	digital 2 r	rear-right
LINE_IN_l	LINE_l ctrl	global_tone	master_l	digital 3 l	centert
LINE_IN_r	LINE_r ctrl	global_tone	master_r	digital 3 r	sub
...

with this, even with the limited set of OSS mixer controls, a really usefull
control was possible - as the volume controls were nothing more than DSP
loaded filters with a driver given modifyable vcalue applied, too.
So changing the volume slider on an oss mixer made the driver to update that
value for the filter, this way it being possible to attach things like a
"cut frequency" to an OSS mixer volume control during runtime

However OSS is deprecated and I wasnt able to run the dsp-mgr coming with the
emu10k1 OSS driver project under my current kernel and architecture :-(

So my question: is a similar functionality implemented in the alsa emu10k1
driver? where are the tools to load those routes using the alsa drivers?
who is working on them? can I help developing them somehow?

regards

Corvus


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
