From: Markus Schoder <markus_schoder@yahoo.de>
Subject: aplay crash in alsa-*-0.9.0beta12
Date: Tue, 12 Mar 2002 01:10:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16kZrk-1VaOzgC@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com [194.25.134.21])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA03788
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2002 01:11:52 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

I experienced crashes with aplay from alsa-*-0.9.0beta12 when playing a
.wav file.  I tracked it down to the snd_pcm_plugin_write_areas
function in pcm/pcm_plugin.c of libasound.

The result variable in the loop can get larger than size.  It is
subtracted from size but since size is unsigned it will wrap
around to an insanely high value and either loop forever or
eventually crash.

The reason for this behaviour seems to be that slave_frames can get
bigger than frames due to some resampling being done in the function
snd_pcm_rate_expand in pcm/pcm_rate.c.

I patched the snd_pcm_plugin_write_areas function by not allowing more
than frames to be subtracted from size.  This fixed the crash but I am
now experiencing some garbage being played at the end of the .wav.

Any ideas?

--
Markus

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
