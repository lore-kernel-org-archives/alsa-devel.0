From: Case van Rij <case@seattle.gii.net>
Subject: snd_pcm_status_*_tstamp() before snd_pcm_mmap_readn ?
Date: Tue, 22 Jul 2003 19:05:28 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030723020528.GA18458@seattle.gii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I'm trying to use a modified aplay.c to do non-stop recording on a
fairly large number of channels, periodically 'rolling over' the output
file in capturev_go( ) before the call to pcm_readv( ) 

So far so good, except I need to get an exact timestamp of the data that
will be returned by pcm_readv( ) .. /test/latency.c seems to do
something do that effect, but I'm not sure if I can just insert

snd_pcm_status(pcm, stat); snd_pcm_status_get_trigger_tstamp(stat,time);

before the pcm_readv( ) (snd_pcm_mmap_readn()) and/or if that returns 
the timestamp of the samples that will be returned .. am I close ? 

Thanks,
Case



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
