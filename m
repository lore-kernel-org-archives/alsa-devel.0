From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 03:39:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40625476.9010801@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

open pcm, and get a handle.

snd_pcm_poll_descriptors(handle, &pfd, err);

Get a poll file scriptor in pfd.

select(nfds, rfds, wfds, efds, tvp);

Is it possible to use this call with alsa ?
It seems that the select functions as expected with the descriptor so 
that we can do a snd_pcm_writei().

It seems that the select does not function so that we can do a 
snd_pcm_readi().

Are there any documents describing how one can get the read (rfds) working?

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
