From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa opl3 api
Date: Fri, 04 Jul 2003 12:44:17 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307041241420.23661-100000@studcom.urz.uni-halle.de>
References: <20030704020832.GG24005@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030704020832.GG24005@dbz.icequake.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ryan Underwood wrote:
> I'm curious, how the OPL3 userspace API in ALSA is operated.  I see that
> in the "Writing an ALSA driver":
> http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1207.htm
> Is the only OPL3 API presented through OSS /dev/dmfm in userspace, or is
> there an alsa-lib interface that I am overlooking?

You can use the "hardware dependent" API (snd_hwdep_open,
snd_hwdep_ioctl) to issue SNDRV_DM_FM_IOCTL_xxx ioctls to the device.


HTH
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
