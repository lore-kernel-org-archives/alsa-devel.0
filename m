From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Subject: snd_pcm_delay() bug
Date: Sat, 15 May 2004 20:46:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084646778.28734.23.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

for both my ALI 5451 and my Audigy 2 NX, snd_pcm_delay() sometimes
returns (in the second argument pointer) ridiculously high values in the
range of 2^32/bytes_per_sample (in my case, 16bitLE/stereo, that comes
down to roughly 1,1E9). I'm guessing there's some kind of
signed/unsigned or 32/64bit integer bug in this function? Is this a
known bug? Is there a fix?

Ronald


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
