From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Audigy 2 SPDIF rates.
Date: Sat, 12 Mar 2005 22:24:00 +0000
Message-ID: <42336C00.5080105@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from anchor-post-36.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9BCC9190
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2005 23:24:01 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-36.mail.demon.net with esmtp (Exim 4.42)
	id 1DAF1c-000AU6-MM
	for alsa-devel@alsa-project.org; Sat, 12 Mar 2005 22:24:01 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have found some more rates that the Audigy 2 SPDIF can run at:

Using the register 0x76 A_SPDIF_RATE.
00 => 48000
20 => 192000
40 => 96000
80 => 44100
No other rates are possible.

To detect the rate, loop the SPDIF output into an input and look at 
register 0x61 GPSRCS

Detected rate = ( ( GPSRCS & 0xFFFFF ) * 48000 ) / 0x40000
or
Detected rate = ( ( GPSRCS & 0xFFFFF ) * 48000 ) / 262144

The GPSRCS register is only valid if 0x51 != 0xffffffff
0x51 is GPSCS which is the SPDIF status register. containing details 
about non-audio bits etc.

Likewise, 0x50 and 0x60 for the CD SPDIF input.

So, the header file should be changed from:
#define A_SPDIF_SAMPLERATE      0x76            /* Set the sample rate 
of SPDIF output          */
#define A_SPDIF_RATE_MASK       0x000000c0
#define A_SPDIF_48000           0x00000000
#define A_SPDIF_44100           0x00000080
#define A_SPDIF_96000           0x00000040

To:
#define A_SPDIF_SAMPLERATE      0x76            /* Set the sample rate 
of SPDIF output          */
#define A_SPDIF_RATE_MASK       0x000000e0
#define A_SPDIF_48000           0x00000000
#define A_SPDIF_44100           0x00000080
#define A_SPDIF_96000           0x00000040
#define A_SPDIF_192000          0x00000020


James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
