From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SoundCards driver work  no correctly.
Date: Mon, 8 Nov 2004 19:02:05 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081858410.16893-100000@studcom.urz.uni-halle.de>
References: <01fa01c4c575$adf756d0$0700a8c0@suiweifeng>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <01fa01c4c575$adf756d0$0700a8c0@suiweifeng>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: weifengsui <fatcat1688@tom.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

weifengsui wrote:
> I am facing problem when program the driver of ALSA HDAudio.

The azx driver was donated by Intel and is considered experimental.
So far, nobody has found time to write a real driver.

> 1, The HDAudio driver can be detected by the ALSA-utils aplay and
> the driver work OK, but it cann't be detected by 'system
> settings/detect sound card'.

Redhat doesn't yet know about it.

> 2, While aplay playback a WAV of 24bit Stereo 48k, the ALSA always
> insert a linear plugin to convert 24Bit into 16Bit,But my hardware
> supports 24Bit.

The driver doesn't yet support 24 bits, even if the hardware does.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
