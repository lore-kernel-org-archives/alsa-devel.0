From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: memory leaks?
Date: Tue, 29 Mar 2005 16:31:56 -0500
Message-ID: <1112131916.5386.6.camel@mindpipe>
References: <1111896886.2408.1.camel@mindpipe>
	 <s5hpsxiiqls.wl@alsa2.suse.de>  <1112127843.5141.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112127843.5141.12.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-29 at 15:24 -0500, Lee Revell wrote:
> On Tue, 2005-03-29 at 14:27 +0200, Takashi Iwai wrote:
> > Yes.  Could you trace the corresponding addresses?
> > (just checking /proc/kallsyms before unloading would help, too).
> 
> How exactly would I trace those addresses?
> 
> Anyway, it looks to me that the leak is in snd_seq_midi.  Here is the
> most recent output.  The first one I'm not sure about, the second seems
> to be in snd_seq_midisynth_register_port.

I might have found it.  The info structure allocated in
snd_seq_midisynth_register_port does not seem to be freed in
snd_seq_midisynth_unregister_port, except on the error paths.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
