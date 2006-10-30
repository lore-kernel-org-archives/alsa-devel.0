From: Fons Adriaensen <fons.adriaensen@skynet.be>
Subject: Demux plugin
Date: Mon, 30 Oct 2006 23:45:11 +0100
Message-ID: <20061030224510.GA9645@linux-1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa Developres <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello all,

Is it possible to create a plugin for alsa-lib that would
do the following:

- I have an ALSA-supported sound card with an SPDIF input
  that provides 2 capture channels at 96 kHz.

- These two signals are actually 4 channels at 48 kHz,
  multiplexed into two in order to trick a 2-ch hardware
  digital recorder to accept the signal.

- The plugin is configured to use hw:N as a slave, and
  presents to the user a new device with 4 channels at
  48 kHz, demultiplexed from its two inputs.

In other words, the plugin has to 'open' the slave with 
modified parameters - the sample rate and period size
requested by the user are doubled and the number of
channels is halved - and to perform the conversion. 
There is no resampling involved, just moving samples
from input buffers to output buffers. The preferred
interface to the plugin would be mmapped.


Is this possible, and if yes how ?
I've been looking at 

  http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_external_plugins.html

but that hasn't made me any wiser...

If it can't be a plugin, what are the other options ?

The reason I will need this is here:

  http://www.core-sound.com/4Mic/2.php


TIA,

-- 
FA

Lascia la spina, cogli la rosa.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
