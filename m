From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx: Center-LFE channel support + a lot of hacking
Date: Sun, 30 Mar 2003 20:51:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E873CA2.2010607@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi!

I've been working of lot things, hopefully all theese changes can 
integrated painless.

Pathes are available for download at:
http://www.cucumelo.org/~gorm/cs46xx.patch  (for 
alsa-kernel/pci/cs46xx/* changes)
http://www.cucumelo.org/~gorm/cs46xx_include.patch (for 
alsa-kernel/include/* changes)

The main new feuture is a new PCM channel:
- Cards with a dual CODEC configuration (2 x cs4294 || 1 x cs4297A + 1 x 
cs4294),
like (Hercules GTXP, Santa Cruz, Terratec SixPack 5.1):
    PCM 0 - slot 3 and 4 (Primary CODEC) main channel
    PCM 1 - slot 7 and 8 (Seconadry CODEC) rear channel
    PCM 2 - IEC958, SPDIF output from the DSP
    PCM 3 - slot 6 and 9 (Seconadry CODEC) left channel is Center and 
right is LFE

    Theoretically it should also possible to support yet another analog 
output on
     slot 11 and 5 on primary CODEC, to support surround 7.1, (Hercules GTXP
     has done something here, but dont exaclty how stuff are wired ...)
- Cards with a single CODEC configuration (1 x cs4294), like Terratec 
XFire 1024:
    (This configuration is untested)
    PCM 0 - slot 3 and 4 (Primary CODEC) main channel
    PCM 1 - slot 11 and 5 (Primary CODEC) rear channel
    PCM 2 - IEC958, SPDIF output from the DSP


- Some changes to the IEC958 input, should be functional by now, but 
still far from
being perfect.

- There is another theoretical problem which will prevent the cs46xx 
work on Big Endian
 architectures. I've started to work on this issue, but not finished yet.
 What's left on this point is to initialize all DSP structs with the C99 
style (.member = value, ...)
 a lot of painful work (anyone like to help me ? -;) )

Known problems (for the moment):
- The Terratec SixPack 5.1 card wont initialize correctly on a cold/warm 
boot.
   A reload of the ALSA driver fixes the problem.
- The IEC958 input port sometimes just stop working, the only thing that 
seems
   to fix it is a cold boot. (a warm reboot does not seems to be enough)
- The analog output's on the SiXPack 5.1 are very distorcionated when 
PCM volumes
 is over ~ 65 %. The only amplified output on this cards seems to be the 
Headphone output.

That's all for now ...

/Benny



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
