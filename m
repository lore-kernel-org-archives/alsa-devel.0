From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions
Date: Wed, 2 Jul 2003 15:29:55 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030702202955.GW24005@dbz.icequake.net>
References: <20030702185006.GU24005@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030702185006.GU24005@dbz.icequake.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Two other things I forgot to mention:

1) What is ALSA's policy on module options?  For example, would it be
okay to add an option like "thinkpad" to the ad1848 module, so that
inserting it with "thinkpad=1" would cause the necessary ports to be
prodded?

2) Since the chip's power mode can be controlled through a write to that
port (bit 2 on, cs4248 power on; bit 2 off, cs4248 power off), would it
be a good idea to add the _suspend, _resume, and _set_power_state
functions within a #ifdef CONFIG_PM block, like in other drivers?


-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
