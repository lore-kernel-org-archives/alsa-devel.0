From: Raymond <rayau@netvigator.com>
Subject: Re: 1.0.9rc1 release
Date: Tue, 15 Mar 2005 14:55:18 +0800
Message-ID: <423686D6.2050704@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

 > > 	1.0.9rc1 ALSA packages are available for download and testing...

For au8830 driver, the message "ALSA control.c:325: control 
3:0:0:Playback PCM advanced processing:0 is already present" is found in 
the kernel log when the driver is creating the first kcontrol for hrtf 
and snd_add_ctl() return -16


#dmesg

Vortex: init.... <6>
ALSA control.c:325: control 3:0:0:Playback PCM advanced processing:0 is 
already present
done.


Raymond



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
