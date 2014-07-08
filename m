From: Sangilikumar  <sangilikumar.muniyandi@marudham.co.in>
Subject: Integrate WM8974 codec with AM1808 processor
Date: Tue, 8 Jul 2014 07:46:45 +0000 (UTC)
Message-ID: <loom.20140708T090201-172@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FDC62602AD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 09:55:05 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1X4QEy-00038B-Cz
 for alsa-devel@alsa-project.org; Tue, 08 Jul 2014 09:55:04 +0200
Received: from 115.114.95.155.static-Chennai.vsnl.net.in
 ([115.114.95.155.static-Chennai.vsnl.net.in])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 09:55:04 +0200
Received: from sangilikumar.muniyandi by
 115.114.95.155.static-Chennai.vsnl.net.in with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 09:55:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Engineers 

      I'm working with TI's AM1808 ARM9 processor. My design in based on 
OMAP-L138 LCDK board. Here i replaced the TLV320AIC310 codec with WM8974 
mono codec. 
      Added the codec driver in board file and registered the sound card by
 
static struct snd_soc_dai_link da850_evm_dai = {
	.name = "TLV320AIC3X",
	.stream_name = "AIC3X",
	.cpu_dai_name= "davinci-mcasp.0",
	.codec_dai_name = "wm8974-hifi",
	.codec_name = "wm8974-codec.1-001a",
	.platform_name = "davinci-pcm-audio",
	.init = evm_aic3x_init,
	.ops = &evm_ops,
};

But got some errors

Sound card registered successfully but i got some errors

wm8974-codec 1-001a: Failed to add route HPLOUT->Headphone Jack
wm8974-codec 1-001a: dapm: unknown pin MONO_LOUT
wm8974-codec 1-001a: dapm: unknown pin HPLCOM
wm8974-codec 1-001a: dapm: unknown pin HPRCOM
asoc: wm8974-hifi <-> davinci-mcasp.0 mapping ok
ALSA device list:
#0: DA850/OMAP-L138 EVM
TCP cubic registered
....

ALSA: Restoring mixer settings...
Configuring network interfaces... Found hardware: "DA850_OMAP-L138" "" "" "" 
""
Hardware is initialized using a generic method
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #1 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #2 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #3 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #4 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #5 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #6 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #7 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #8 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #9 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #10 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #11 
(No such file or directory)
/usr/sbin/alsactl: set_control:1267: failed to obtain info for control #12 
(No such file or directory)
davinci_mdio davinci_mdio.0: resetting idled controller

root@omapl138-lcdk:/aud# speaker-test
 
speaker-test 1.0.24.2
 
Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 128 to 32768
Period size range asoc: machine hw_params failed
from 8 to 2048
Using max buffer size 32768
Periods = 4
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument
root@omapl138-lcdk:/aud# 
 
Please let me know what are the changes i need to do in Linux files and 
drivers.
