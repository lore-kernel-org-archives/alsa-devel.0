From: Shaju Abraham <shaju@multitech.co.in>
Subject: ALSA crash
Date: Fri, 19 Jul 2002 16:49:20 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D37F5B8.AE18A86B@multitech.co.in>
References: <3D328503.5000705@renta.net> <s5hvg7h9umz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
        Pls check the attached file that is dmesg of a ALSA crash. Can
you pls tell under what conditions this happens?

Another thing ... in pcm_lib.c , for the funtion  snd_pcm_update_hw_ptr.
, there is a comment that "this should be called with interrupts
disabled". Can you tell us who is disabling the interrupts just before
this is called?

Does spin_lock_irq do that?

We are using RedHat 7.1 linux on i810 motherboard and the latest version
of ALSA 0.9.0.

Shaju Abraham.

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -46, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -4, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -4, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -6, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -6, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -56, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -2, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -6, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -4, max jitter = 4480): wrong interrupt acknowledge?

ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -68, max jitter = 4480): wrong interrupt
acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:188: Unexpected hw_pointer value
(stream = 0, delta: -4, max jitter = 4480): wrong interrupt acknowledge?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
