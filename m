From: Fredrik Lingvall <fl@signal.uu.se>
Subject: DAC Direct Mode on ALi 5451
Date: Sun, 11 May 2003 20:23:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBE9534.9060203@signal.uu.se>
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

The Cirrus Logic CS4299 audio chip used in the ALi 5451 chipset has a 
DAC Direct Mode which sends the DAC output directly to the line output
drivers. Does anyone know how to enable this mode? I have tried the
alsamixer (and gnome-alsamixer) but there is no such switch in these
apps.

Background: I want to process the adio data from the ADC:s (eg. FIR 
filter the audio data) and then send the processed audio stream to the 
DAC:s and the line out on my laptop (Acer TM 636). To do this I must 
mute the PCM line in the mixer which otherwise feeds back into the ADC:s 
(see Figure 8.mixer diagram in: 
http://www.alsa-project.org/alsa/ftp/manuals/cirrus/cs4299-4.pdf)
but this also kills the PCM output. However, if the DAC Direct Mode bit 
is set (bit 8 in the AC Mode Control Register (5Eh)) the PCM stream will
be send to the line out by-passing the mixer.

Fredrik



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
