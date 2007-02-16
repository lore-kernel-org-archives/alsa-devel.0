From: Jean-Michel =?ISO-8859-1?Q?Pour=E9?= <jmpoure@free.fr>
Subject: Edirol UA-25 dmix broken at 48 Khz
Date: Fri, 16 Feb 2007 11:26:16 +0100
Message-ID: <1171621576.4524.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dear Friends,

Just a short note to notice that Edirol UA-25 dmix is broken at 48 Khz,
in advance mode.

aplay -D default -v  foobar.wav
ALSA lib pcm_direct.c:897:(snd_pcm_direct_initialize_slave) requested or
auto-format is not available
ALSA lib pcm_dmix.c:876:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:550: audio open error: Argument invalide

Is this a bug?
Should I install Alsa CVS version for the dmix fix?

Kind regards,
Jean-Michel

**************************************************************

My .asoundrc file:
pcm.!default {
   type             plug
   slave.pcm       "softvol"
}
pcm.softvol {
   type            softvol
   slave {
       pcm         "pasymed"
   }
   control {
       name        "SoftMaster"
       card        0
   }
}
#This PCM combining the dmix and dsnoop slaves
pcm.asymed {
      type asym
      playback.pcm "dmix"
      capture.pcm "record_left"
}  
#This PCM should be able to convert recording rates automatically
pcm.pasymed {
      type plug
      slave.pcm "asymed"
}
pcm.record_left {
   type        dsnoop
   ipc_key 234884
   slave {
       pcm     "hw:0,0"
       channels 2
   }
   bindings.0  0
}
pcm.record_right {
   type        dsnoop
   ipc_key 2241234
   slave {
       pcm     "hw:0,0"
       channels 2
   }    
   bindings.0  1
} 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
