From: Friedrich.Ewaldt@gmx.de
Subject: S/P-DIF output seems to work with Terratec XFire (=> CS4624 => cs46xx)
Date: Fri, 26 Jul 2002 21:14:55 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <18347.1027710895@www15.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: gorm@cucumelo.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Benny,

I've just tested your CS46xx driver (alsa-driver-0.9.0rc2-bs20020723.tar.gz)
with my Terratec XFire soundcard (CS4624). 
Everything that worked before (alsa09beta9) seems to be working with the new
driver, too :^)

SPDIF output feature:
Unmuting/muting the IEC 958 item in alsamixer switches the optical output of
my soundcard on/off.
To be more precisely: I can see the LED going on/off but do not know any
digital audio data is send through it. (The only digital input device I have is
my soundcard and the digital input is only working under windows up to
now...).
I can switch on/off the SPDIF output correctly approx. 10-20 times. After
that, muting/unmuting the IEC 958 item with alsamixer causes the PCM output
(line out) to switch on/off (unmuting SPDIF mutes the PCM. Sometimes I get a
high frequency tone instead of the PCM output until I mute the SPDIF output).
I've tried restarting alsa ("alsa restart" as root), but that didn't help.
After rebooting, everything seems to be working allright as before (I can
switch on/off the SPDIF several times before the error occurs again).

Another question: Do you have any idea what's the reason for something that
seems to be an DC offset of the PCM (changing the volume of pcm or master
makes some noise)?
Restarting alsa solves this problem until next reboot. (The same problem
existed with the beta9 driver version)

cheers,
fritz_e

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
