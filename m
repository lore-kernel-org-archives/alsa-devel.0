From: Dirk Jagdmann <doj@cubic.org>
Subject: Alsa support for Realtek ALC850
Date: Mon, 18 Apr 2005 12:39:36 +0200
Message-ID: <42638E68.9080400@cubic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hello developers,

I recently purchased an ASUS P4P800-E mainboard which features i865 
chipset with an Realtek ALC850 AC'97 Codec. This codec is recognized by 
the i8x0 drivers (I tested this with Alsa 1.0.8) as an 6 channel device. 
However this chip supports 8 channels, but this is not 
supported/recognized by Alsa currently. I had a quick look into the i8x0 
sources, but did not find the correct spot, where to patch the source to 
support 8 channels. I ask you for assistance on this subject. Please 
tell me which contents of /proc or /sys you'd like to see or please give 
me some pointers into the source.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
