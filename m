From: Glenn Maynard <g_sf@zewt.org>
Subject: Detecting ALSA OSS emulation
Date: Mon, 8 Dec 2003 07:06:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031208120657.GD535@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Is there a reliable way to find out if /dev/dsp is being handled by
ALSA?  I want to be able to detect this for diagnostics.  (If /dev/dsp
is ALSA, the native alsa-lib code should have been used, and something
has gone wrong.)  Currently, I'm checking for the existance of
/proc/asound/version, but at least one user had a configuration where
that file existed but /dev/dsp was really OSS.

(That's what it looked like, and what he claimed, at least; I havn't
tried to reproduce that configuration, with both ALSA and OSS loaded
and only OSS actually handling sound.  It's possible something else
was happening and the user was wrong.)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
