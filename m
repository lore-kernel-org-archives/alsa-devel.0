From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: Audio and Video sync. Getting Timestamps
Date: Fri, 07 May 2004 11:52:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <409B786B.3050607@superbug.demon.co.uk>
References: <1083748400.4098b030eeb58@www.telecable.es> <s5hn04n1aer.wl@alsa2.suse.de> <002501c433c2$70a06b90$a6b06153@palmian> <409AD205.1010900@superbug.demon.co.uk> <yw1xk6zoen8d.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xk6zoen8d.fsf@kth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Måns Rullgård wrote:
> James Courtier-Dutton <James@superbug.demon.co.uk> writes:
<snip>

> 
> The OP was recording.
> 

Oops. My explanation only covers playback, not capture.
But if you use the snd_pcm_avail_update() just before you capture some 
samples from the buffer, then do a gettimeofday(), you will get an 
accurate measure of when the samples arrived in the buffer.
If you also use a thread and get it to do poll(), you could also keep 
the latency down, with it calling the routine on each period elapsed.

Summary: Use a method similar to the playback method, but just modify it 
a be for record.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
