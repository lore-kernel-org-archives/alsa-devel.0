From: Meelis Roos <mroos@linux.ee>
Subject: snd-cs4281 and default buffer size
Date: Mon, 12 Jun 2006 14:17:28 +0300 (EEST)
Message-ID: <Pine.SOC.4.61.0606121409370.24571@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yesterday I struggled with Skype on IBM X20. This laptop has CS4281 
onboard that didn't work in 2.6.16 but is working in 2.6.17-rc*. Mplayer 
and most other applications work OK, with both native ALSA and 
snd_pcm_oss emulation.

But Skype had very distorted and chopped sound. Some googling showed 
that people use the following two lines to change (increase?) the 
buffer sizes in OSS emulation to get it to work. These 2 lines fixed it 
for me too:

echo "skype 256 65535 direct block" > /proc/asound/card0/pcm0p/oss
echo "skype 256 65535 direct block" > /proc/asound/card0/pcm0c/oss

But this seems to be needed only for some sound drivers, other work wine 
out of the box (there's been a lot of discussion about this in Skype 
forum).

Leaving aside the weak sound support in Skype, why do some drivers need 
increasing the buffers and some don't?

-- 
Meelis Roos (mroos@linux.ee)
