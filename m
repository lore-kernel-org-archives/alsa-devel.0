From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: problems with mono audio.
Date: Thu, 11 Mar 2004 19:10:05 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4050B98D.3030104@superbug.demon.co.uk>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Which devices can a mono stream be played on?
It seems that the only device a mono stream can be played on is the 
"default" pcm device.

Devices like "front" and "rear" are stereo only devices.
It would be nice if alsa-lib would open one of these devices, and if the 
application tries to set 1 channel instead of 2, then somehow make 
alsa-lib do the duplication of the channels.

A similar thing should happen for "surround40" device. If 1 channel is 
asked for, alsa-lib should duplicate it for all channels. If 2 channels 
are asked for, then alsa-lib should create 4 channels automatically.

alsa-lib seems to manage to do this sort of thing for sample rates, and 
sample formats, why not number of channels ?

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
