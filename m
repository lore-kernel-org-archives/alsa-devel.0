From: Steve Strobel <steve.strobel@link-comm.com>
Subject: OSS app works but aplay does not with
	SNDRV_PCM_FMTBIT_U32_LE
Date: Tue, 18 Sep 2007 12:38:24 -0600
Message-ID: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 4153124527
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 20:38:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am developing an ALSA driver for the AD1938 codec on uClinux for 
Blackfin (I don't believe my problem is specific to that 
platform).  When I set up the snd_pcm_hardware_t structure with

   .formats =          SNDRV_PCM_FMTBIT_S32_LE,

I can run both "aplay < /dev/urandom" and an OSS test application 
("tone") that sends a sine wave, but the sine wave is "inside out" 
(see <http://www.link-comm.com/temp/inside_out.gif> for a screen 
shot) because the codec needs unsigned data.

If I set up the snd_pcm_hardware_t structure with

   .formats =          SNDRV_PCM_FMTBIT_U32_LE,

the OSS test application sends a nice sine wave, but aplay fails with 
the following messages:

root:~> aplay < /dev/urandom
ALSA sound/blackfin/ad1836.c:1050: snd_ad1836_playback_open
Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
snd_pcm_hw_refine()
ACCESS = 00000000ffffffffffffffff -> 0000000000000008
FORMAT = 0000000000000400 -> 0000000000000000
snd_pcm_hw_refine()
ACCESS = 333f8fc000a32c60c0333f8fc -> 333f8fc000a00000008
ALSA lib ALSA sound/blackfin/ad1836.c:1172: snd_ad1836_hw_free
../../../src/pcm/pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave 
PCM not usable
aplay: set_params:882: Broken configuration for this PCM: no 
configurations available

I am working my way through the ALSA source, but I have not yet 
figured out why aplay won't work with the unsigned codec 
configuration.  Any suggestions?

Steve

P.S.  A more complete log of the console output with both settings 
for those commands and most of the info from aadebug can be found at 
the following URLs:
<http://www.link-comm.com/temp/SNDRV_PCM_FMTBIT_S32_LE.txt>
<http://www.link-comm.com/temp/SNDRV_PCM_FMTBIT_U32_LE.txt>

---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com
