From: Christian Esken <c.esken@cityweb.de>
Subject: cs64xx distortion (GameTheater XP)
Date: Thu, 16 Jan 2003 00:14:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301160014.11787.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

I wonder what the status of the cs64xx distortion problem is.
I tested the 2003-01-14.tar.bz2 snapshot with my GameThaeter 7.1 XP
and it still shows those heavy distortions on analog output.

Digital out is OK most of the time, but sometimes fails (as described in cs62xx_lib.c).
I thought you might be interested in the syslog:

PCI: Found IRQ 7 for device 00:0a.0
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3855: hack for Hercules Game Theatre XP enabled
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3866: Crystal EAPD support forced on.
ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?

I am wondering about the status, as there is still this comment in cs64xx_lib.c:
---------------------------
        /* CD mute change ? */

        /* Benny: this hack dont seems to make any sense to me, at least on the
Game Theater XP,
           Turning of the amplifier just make the PCM sound very distorcionated.           is this really needed ????????????????
        */
---------------------------

And what about CONFIG_SND_CS46XX_NEW_DSP? I left the default, which seems to be
-DCONFIG_SND_CS46XX_NEW_DSP=1
Which means, the "CD mute change" stuff is not compiled in at all.


Bye,
  Chris

being terribly confused at the moment - hoping for enlightenment :)


-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
