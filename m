From: Mark Knecht <markknecht@comcast.net>
Subject: 1.0.0rc2 report on aoss
Date: Sun, 07 Dec 2003 11:41:50 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070826110.2566.8.camel@Wizard.knechthome.com>
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

Hi,
   I've was asked to try 1.0.0rc2 aoss support and to report back on my
results. This email intended to do that. Bottom line is rc2 is better
than previous versions, but nothing is working 100% as expected.

1) My .asoundrc file is at the end of this message.

2) If I run xmms using OSS I get audio on all 26 playback channels and
pops at the start of playback.

3) If I run 'aoss xmms' I get audio on playback channels 1 & 2 instead
of 5 & 6 as specified.

4) If I run 'alsaplayer -o oss' I get audio on all 26 channels and no
pops at the start of playback. 

5) If I run 'aoss alsaplayer -o oss' aoss dies:

bash-2.05b$ aoss alsaplayer -o oss
/usr/bin/aoss: line 9:  2650 Segmentation fault     
LD_PRELOAD=${exec_prefix}/lib/libaoss.so $*
bash-2.05b$ 

   Please let me know if something else needs to be tested, but there
are two problems at least here that should be looked into.

Thanks,
Mark

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




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
