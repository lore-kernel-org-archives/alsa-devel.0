From: Mark Knecht <markknecht@comcast.net>
Subject: aoss failures under Alsa-1.0.0rc1
Date: Thu, 04 Dec 2003 05:06:37 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070543197.2081.30.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

bash-2.05b$ aoss xmms

(At this point the xmms gui opens. I then press play)

xmms: alsa-oss.c:222: oss_dsp_hw_params: Assertion `err >= 0' failed.
/usr/bin/aoss: line 9:  2841 Aborted                
LD_PRELOAD=${exec_prefix}/lib/libaoss.so $*
bash-2.05b$ 


Contents of my .asoundrc file:


pcm.hdsp {
           type hw
           card 0
         }

ctl.hdsp {
           type hw
           card 0
         }

pcm_slave.hdsp {
          pcm "hw:0"
          channels 26
        }

pcm.playback_5_6 {
          type dshare
          slave hdsp
          ipc_key 314159265    # some unique number
          ipc_key_add_uid yes  # "no" to let multiple users share it
          bindings {
                0 5
                1 6
          }
        }

pcm.dsp0 {
          type plug
          slave.pcm playback_5_6
        }





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
