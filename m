From: Richard Chan <rspchan@starhub.net.sg>
Subject: Audacity-devel reports bug in Alsa OSS emulation
Date: Thu, 19 Feb 2004 02:03:26 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4033A8EE.1030701@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
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

Hi,

I'm using Audacity with Alsa OSS emulation - I have observed an infamous 
Audacity cursor bug
with Alsa OSS emulation. Another user has tracked it down as follows:

Quote:

" I made some investigations about this problem and discovered that the ALSA
OSS emulation is broken: ioctl(fd, SNDCTL_DSP_GETOPTR, &info) sometimes
returns wrong results.
I do not know ALSA enough to fix it, but I have patched an audacity source
file as a workaround."

Known bug? Worth fixing?

Regards
Richard


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
