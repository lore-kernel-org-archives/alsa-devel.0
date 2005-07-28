From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: problem with ALSA 1.09 and 2.6 kernel (AGNULA/Demudi)
Date: Thu, 28 Jul 2005 09:59:49 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507280957410.9785-100000@studcom.urz.uni-halle.de>
References: <42E7ABC0.4010909@linux-sound.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E7ABC0.4010909@linux-sound.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Phillips <dlphilp@linux-sound.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dave Phillips wrote:
>   Some updates: I now have the CS4232, the PDAudioCF (Thank you!), and
> the Midisport 2x2 working with Demudi 1.2.1 and ALSA 1.0.9rc2. My final
> hurdle shouldn't be too difficult to get over:
>
>     demudi:/home/dlphilp# modprobe snd-virmidi
>     FATAL: Error inserting snd_virmidi
>
> (/lib/modules/2.6.12-3-multimedia-686/kernel/sound/drivers/snd-virmidi.ko):
> No such device

Any error message in the system log?

Probably the index option isn't set correctly?  How does your
modprobe.conf (or whatever Demudi uses) look now?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
