From: Miles Lane <miles.lane@attbi.com>
Subject: 2.5.70-bk7 (alsa 0.9.4) -- sound/usb/usbaudio.c:1947: `iface_no'
 undeclared (first use in this function)
Date: Mon, 02 Jun 2003 14:47:46 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EDBC602.4060905@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

   CC [M]  sound/usb/usbaudio.o
sound/usb/usbaudio.c: In function `parse_audio_format_i_type':
sound/usb/usbaudio.c:1947: `iface_no' undeclared (first use in this 
function)
sound/usb/usbaudio.c:1947: (Each undeclared identifier is reported only once
sound/usb/usbaudio.c:1947: for each function it appears in.)
sound/usb/usbaudio.c:1947: `altno' undeclared (first use in this function)
make[2]: *** [sound/usb/usbaudio.o] Error 1

CONFIG_SOUND=m
# CONFIG_DMASOUND_AWACS is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

# ALSA PowerMac devices
#
CONFIG_SND_POWERMAC=m

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
