From: "Pavana Sharma" <pavans@india.ti.com>
Subject: OSS mapping for ALSA controls
Date: Wed, 7 Apr 2004 19:38:18 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02cc01c41ca9$c764a890$f8b6a8c0@ent.ti.com>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi,

	I am trying to map my ALSA driver (for ARM) controls with OSS default
controls.

	I am using this method, to change/update assignment in /proc file.
	but I am not seeing any changes in my /proc/asound/card0/oss_mixer file.
	% echo 'VOLUME "Master Playback" 0' > /proc/asound/card0/oss_mixer
	Is this the write way to do it ? or do need to follow someother procedure
to map the alsa mixer ioctls with oss.
Thanks
Pavana S



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
