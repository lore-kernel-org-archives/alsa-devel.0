From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: How to add full duplex capture and playback?
Date: Fri, 19 May 2006 11:29:56 +0200
Message-ID: <446D9014.1070300@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

I'm strugling a bit with getting my AC97 driver to be full duplex. The
hardware supports it, but I can't seem to enable it correctly in the driver.

Is there anything I've missed other than this?
err = snd_pcm_new(chip->card, "Atmel AC97", 0, 1, 1, &pcm);

AFAIK this should give me two substreams, one for capture and one for
playback. Do I have to take some care with other calls?

When I try to playback and record simultaneously I get the following error:
ALSA lib pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not usable
aplay: set_params:879: Broken configuration for this PCM: no
configurations available

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
