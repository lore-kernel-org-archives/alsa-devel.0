From: Andrew Gaydenko <a@gaydenko.com>
Subject: ice1724, OSS tuning
Date: Sat, 12 Mar 2005 00:51:12 +0300
Message-ID: <200503120051.12443@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

Hi,

I have problems in working of OSS emulation for some lib (it is plib, if it does
matter). After digging in docs, I have found the only way to tune emulation - via
/proc commands like 'echo "playsound 4 1024 non-block" > /proc/asound/card0/pcm0p/oss'.
But I have not achieved full success here.

Are there another ways to tune OSS emulatin working?

Are there some known problems of OSS emulation for ice1724/Aureon71 card?

P.S. I have tried both 1.0.8 and current CVS versions.

Thanks!
Andrew



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
