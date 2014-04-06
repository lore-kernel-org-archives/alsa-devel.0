From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 18/44] fireworks: Add connection and stream management
Date: Sun, 06 Apr 2014 22:20:34 +0900
Message-ID: <534154A2.8030607@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-19-git-send-email-o-takashi@sakamocchi.jp>
	<533DCB08.3040404@ladisch.de> <533EC039.7080907@sakamocchi.jp>
	<533ECA22.5010509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533ECA22.5010509@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens

(Apr 5 2014 00:05), Clemens Ladisch wrote:
> It must be called when the driver is disconnected normally (I guess in
> snd_efw_stream_destroy_duplex), or when driver amdtp_stream_init() has
> succeeded but driver loading aborts due to some other error.
>
>> is it due to reference counter of firewire unit? (fw_unit_get/put)
>
> Yes, and any other resources it might have allocated.

Oops. Indeed. And all of patches which I've posted don't include 
amdtp_stream_destroy()! I completely forgot it, for a long time...

Thanks for your indication


Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
