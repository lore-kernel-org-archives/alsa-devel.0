From: Antti Boman <antti.boman@mindcom.fi>
Subject: snd-cmipci with Jack not working
Date: Wed, 29 Jan 2003 11:27:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E379E8A.10502@mindcom.fi>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I and a few other people have tried to get snd-cmipci (8738 integrated 
into ASUS A7V266 motherboard) work with Jack Audio Connection Kit, but 
with no success. We tried solving this problem in jack's developer list, 
but as there was no success I though (and was adviced) it might be the 
ALSA driver problem.

The thread about the problem can be found at
http://sourceforge.net/mailarchive/forum.php?thread_id=1580464&forum_id=3040

I've gathered the key information here:

- The sound when playing back is totally garbled, the pitch is lower
  than the original, and I get lots of clicking alongside. If I'm not
  using jack but alsa output, everything (playing and recording) is ok.

- I have the lowlat patch installed in kernel, but using or not using it
  doesn't seem to change anything.

- The irq for the "card" is 10, and doesn't seem to be shared. I also
  have .asoundrc set up.

- Jack server->client operation works ok, but playing back and recording
  cause the troubles.

- After watching /proc/asound/card0/pcm0p/sub0/status and
  /proc/asound/card0/pcm0c/sub0/status, it seems that the wake-up does
  not happen in time although using relatively large buffersizes, or:

- the playback and capture directions might be driven by different
  clocks (i.e. they run at different speeds)

- Using jackd with playback/capture only, it produces the following
  message:
   jackd: pcm.c:5851: snd_pcm_mmap_commit: Assertion 'pcm' failed

- If using kernel real-time patches with playback/capture only, the
  system locks up. This doesn't happen with both capture and playback
  enabled.

More can be found in the thread.

Anyway, we ran into dead-end. I'm very willing to answer any questions 
you may have, test any configuration you're suggesting, or debug 
anything you want me to debug.

And no, I still don't know if it's a Jack or ALSA driver problem. What 
I've read, though, is that people with other drivers (or chipsets) 
haven't had these kind of problems, and there are at least two reports 
on the same problem with users of C-Media 8738 with jack.

Thanks for any help!

-Antti Boman



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
