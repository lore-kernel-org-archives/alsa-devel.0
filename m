From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Running ALSA on embedded system (PowerPC 405EP)
Date: Mon, 8 Nov 2004 18:31:16 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081829590.16893-100000@studcom.urz.uni-halle.de>
References: <6.0.1.1.0.20041102164518.01c8a3e0@192.168.2.1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <6.0.1.1.0.20041102164518.01c8a3e0@192.168.2.1>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: llandre <r&d2@dave-tech.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

llandre wrote:
> I'm trying to build ALSA drivers, libs and utilities on an embedded
> platform. The CPU is PowerPC 405EP by IBM. The kernel is 2.4.20.
> After some work I successfully built and installed the following packages:
> drivers: 0.9.0rc6
> library: 0.9.0rc1
>
> alsamixer: function snd_mixer_load failed: Inappropriate ioctl for device

Looks like incompatible driver/library versions.

> I tried to build newer packages but I was not able to compile them

What exactly is the problem?


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
