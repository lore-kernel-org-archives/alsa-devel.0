From: David van Hoose <davidvh@cox.net>
Subject: Re: ALSA 0.9.3+ is not working
Date: Mon, 02 Jun 2003 08:23:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EDB41C9.80801@cox.net>
References: <Pine.HPX.4.33n.0306021233330.26812-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306021233330.26812-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> David van Hoose wrote:
> 
>>Sound card is onboard SiS7012 AC'97 (CMI9739A)
>>0.9.2 works perfectly.
>>0.9.3a Sound through CD-ROM (Plays CDs) No sound through OSS apps.
> 
> 
> Does playing sounds with aplay work?

Just noticed the following lines in my /var/log/messages. Maybe they'll 
help.

ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer value 
(stream = 0, delta: -1105, max jitter = 4456): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer value 
(stream = 0, delta: -1096, max jitter = 4456): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer value 
(stream = 0, delta: -1090, max jitter = 4456): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer value 
(stream = 0, delta: -1086, max jitter = 4456): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer value 
(stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?

The messages seem to come in groups.

I also found this in another messages file. I think from 2.5.70-bk6.
Jun  1 17:08:02 aeon kernel: ALSA ../alsa-kernel/core/pcm_lib.c:143: 
BUG: stream = 1, pos = 0x22d0, buffer size = 0x22d0, period size = 0x45a

Thanks,
David



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
