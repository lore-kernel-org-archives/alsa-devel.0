From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Major problem with the current alsa mixer.
Date: Fri, 12 Sep 2003 01:14:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F610FE4.2040009@superbug.demon.co.uk>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

There is a MAJOR problem with the current alsa mixer.
How do I set a mixer volume to the 0 db point. I.E. no attenuation, and 
no gain.
Currently, we might have a value from 0 to 100%. Percent of what?
What this value means varies depending on the sound card hardware being 
used.
I think that this should all be changed to signed values, with a max and 
a min setting. With a value of 0 being equivalent to no-gain, 
no-attenuation. Each alsa-driver would then convert this signed value 
into a value actually written to the hardware register via a lookup table.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
