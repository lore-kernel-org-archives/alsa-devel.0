From: Gerard Janssen <g.janssen@ITS.TUDelft.NL>
Subject: Strange problem: no sound samples from ALSA
Date: Sun, 30 Mar 2003 19:54:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.1.5.2.20030330192158.014fa700@Octopus.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@alsa-project.org, alsa-devel@alsa-project.org
Cc: Anders Torger <torger@ludd.luth.se>
List-Id: alsa-devel@alsa-project.org

Dear all,

Since I am using my new PC (ASUS P4PE; with AD1980 sound chip; 2.4 GHz 
Pentium 4, a Terratec card based on ice1712 and an SBLive card; Suse 8.1) I 
cannot send audio data from ALSA to the application Brute FIR. I am using 
BruteFIR, a fast convolution program, in combination with ALSA. On my old 
system (ASUS PB3F; 500 MHz Pentium 3; sblive card; SUSE 8.0) it worked 
fine. Using ALSA 0.9.0rc6 or ALSA 0.9.2 on my new system does not make a 
difference.

I am doing the following: digital audio samples are send from the CDROM 
(SPDIF output) to the SPDIF input of the SBLive. This works, since I can 
control the volume via the "optical spdif input" volume control, and play 
the music via the front speakers. So far so good.
However, now I want to filter the music using Brutefir, however, this 
application does not receive data from ALSA. Can this output some how be 
muted? Previously, the sound level from the stream send from ALSA to 
Brutefir was only controlled by the "optical spdif input" volume control.

Installing only the sblive in ALSA (./configure --with-cards=emu10k1) 
results in the same problem.
The only real difference seems to be the presence of three sound devices.

Any help in solving this problem is very much appreciated.

Thanks,

Gerard Janssen




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
