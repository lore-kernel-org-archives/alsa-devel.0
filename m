From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Dmix using more CPU than plug:hw
Date: Sat, 7 May 2005 09:53:46 +1000
Message-ID: <20050507095346.37b16e6a.erikd-alsa@mega-nerd.com>
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


Note : Please CC me on responses as I am not subscribed to this 
list.

Hi all,

I'm playing around with Polypaudio (an EsoundD replacement) and
find that it works really well when I connect it to the plug:hw
and the CPU usage is as I would expect.

If on the other hand I connect Polypaudio to the plug:dmix1
(defined as below) device it attempts to chew up 100% of CPU and 
then dies.

The ALSA version is whatever is in the 2.6.11 kernel. I have also
seen this problem on two different systems (iBook/Tumbler and
ia32/CMI8738) so its not hardware specific.

Does anyone have any ideas as to why a dmix device behaves so
differently to plug:hw?

TIA,
Erik


pcm.dmix1 {
   type dmix
   ipc_key 1024
   slave {
       pcm "hw:0,0"            # make sure this matches the actual device
       #period_time 0          # not necessary since ALSA 1.0pre
       period_size 1024        # Use a power of 2
       buffer_size 4096        # must be a multiple of period_size
       #rate 44100             # not necessary; let alsa-lib handle this
   }
   bindings {
       0 0
       1 1                     # bind only the first 2 channels
   }
}
pcm.duplex
{
   type asym
   playback.pcm "dmix1"
   capture.pcm "dsnoop"
}
# Everything shall be dmix1ed, so redefine "default":
# Note that this is _not_ a good idea, since dmix1 doesn't allow mmap access currently
#pcm.!default {
#   type plug
#   slave.pcm "duplex"
#}
# OSS via aoss should d(mix)stroyed:
pcm.dsp0 {
   type plug
   slave.pcm "duplex"
}
ctl.dmix1 {
   type hw
   card 0
}


-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"OS X is great that way.  I put a copy of OS X on my coffee table,
and it hasn't been hacked yet. Yes, I am using it as a server. I
serve several meals on it every week." -- Anthony Minkoff


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
