From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 15:48:59 +0100
Message-ID: <49008EDB.2090704@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 920F91038F4
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 16:49:09 +0200 (CEST)
In-Reply-To: <s5habcv5mu0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Anyway, could you try the patch below?
>
> And, if it's reproducible (just try mplayer first without aplay),
> then you can add printk()'s and delays in each PCM callback to see
> where this happens, for example.
>   

Running mplayer freezes the PC every time.
strace  confirms it is always at the same point.
Tail end of the strace output is below.

SysReq keys dont respond once it has locked up.

Regards, Jason

futex(0x9a008ec, FUTEX_WAIT_PRIVATE, 1, NULL) = 0
write(2, "*** PULSEAUDIO: Unable to connec"..., 144*** PULSEAUDIO: 
Unable to connect: Connection refused
*** Is your sound server running?
*** See: http://www.pulseaudio.org/wiki/Troubleshooting
) = 144
futex(0x99fb050, FUTEX_UNLOCK_PI, 1331188) = 0
write(7, "W", 1)                        = 1
futex(0x99fb050, FUTEX_UNLOCK_PI, 1331188) = 0
munmap(0xb7b89000, 2097176)             = 0
unlink("/dev/shm/pulse-shm-663979755")  = 0
close(6)                                = 0
close(7)                                = 0
close(5)                                = 0
close(4)                                = 0
munmap(0x802000, 23856)                 = 0
write(2, "[AO_ALSA] Playback open error: C"..., 50[AO_ALSA] Playback 
open error: Connection refused
) = 50
open("/dev/dsp", O_WRONLY|O_NONBLOCK|O_LARGEFILE) = 4
fcntl64(4, F_SETFL, O_RDONLY)           = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
ioctl(4, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS
