From: Mark Knecht <markknecht@comcast.net>
Subject: rc2 - snd-via82xx - really sounds bad - distorted, resampled,
 phasey
Date: Sun, 07 Dec 2003 13:44:42 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070833482.2913.82.camel@Wizard.knechthome.com>
References: <1070820195.3841.42.camel@Wizard.knechthome.com>
	 <3FD3716A.9010009@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FD3716A.9010009@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-12-07 at 10:28, Patrick Shirkey wrote:
> (Some people have been known to 
> invest in a second $10 card just for browsing).
> 

Patrick, 
   Hi. Ok, since you suggested it I set up this Via 8235 sound chip on
my system as the primary sound chip. However, it's sounding amazingly
bad! It's terribly distorted and even at the best of times sounds very,
very,phasey. I can pretty much hear what sound like terrible resampling
noise, maybe like it's going from 44.1K up to 48K or something.

Any idea why? I hope it's just a configuration mistake.

I've tried both alsaplayer and xmms playing a few mp3's and the results
are always the same going through the 8235.

The 8235 output is cabled to an input on the AI-3 A/D, inputs 3/4. I've
also got Pro Tools coming in on inputs 1/2. Audio from Pro Tools is
fine, while audio from the 8235 is dirty, resampled and phasey. The AI-3
does not show any clipping on the signal coming from the 8235, so I
don't think it's really a levels issue.

Is the 8235 a 44.1K only type device? I don't think so since I see 44.1K
number in /proc/asound/card0/

I haven't figured out how to run alsaplayer directly though Alsa when
the HDSP is the second card, but using Jack I can run alsaplayer and the
sound is much better.

I think there have been similar comments since rc1 about this sort of
thing on the Intel sound chips possibly? Are others using rc2
successfully with this chip or could this be a similar problem?

The sound is so bad as to be unlistenable. 

Current .asoundrc and modules.conf below...

Thanks,
Mark

pcm.via82xx {
           type hw
           card 0
         }

ctl.via82xx {
           type hw
           card 0
         }

pcm.hdsp {
           type hw
           card 1
         }

ctl.hdsp {
           type hw
           card 1
         }

pcm_slave.hdsp {
          pcm "hw:0"
          channels 26
        }

pcm.playback_5_6 {
          type dshare
          slave hdsp
          ipc_key 314159265    # some unique number
          ipc_key_add_uid yes   # "no" to let multiple users share it
          bindings {
                0 5
                1 6
          }
        }

pcm.dsp {
          type plug
          slave.pcm playback_5_6
        }


# ALSA portion
alias char-major-116 snd
# OSS/Free portion
alias char-major-14 soundcore

##
## IMPORTANT:
## You need to customise this section for your specific sound card(s)
## and then run `update-modules' command.
## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
##

##  ALSA portion
alias snd-card-0 snd-via82xx
alias snd-card-1 snd-hdsp
alias snd-card-2 snd-usb-audio


##  OSS/Free portion
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
##

# OSS/Free portion - card #0 (Via8233)
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# OSS/Free portion - card #1 (HDSP9652)
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

# Set this to the correct number of cards.
options snd cards_limit=3
add options -k snd-card-0
add options -k snd-card-1
add options -k snd-card-2

### modules-update: end processing /etc/modules.d/alsa




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
