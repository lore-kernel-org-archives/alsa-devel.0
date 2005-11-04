From: "Nambiar, Anil" <NambiarA@sharpsec.com>
Subject: switching between mic and line-in
Date: Fri, 4 Nov 2005 17:58:54 -0500
Message-ID: <6A09F73E2878E447BF6B87C43162C8270215463B@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,
	I have a h/w which has 2 inputs and 2 outputs for the audio using
AC94 codec. For the output I have headphone and speaker out. When the
headphone is connected, I can detect the interrupt and switch between
headphone and speaker out at the driver level, so it's not a problem. 
       But for the input, there is no interrupt and I need to switch between
the mic and line-in based on what the user application selects. Now in AC97
codec chip, the capture input can be switched between mic and line-in by
changing a few bits. Is there any IOCTL in alsa which I can use to switch
between mic and line-in.
	The solution so far I have seen is to use two capture devices in the
driver. Is that the only way? If that is the case, how do I obtain mutual
exclusion, so that at any given time only one capture device is opened?
	I appreciate all the help.
Thanks,
AniL




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
