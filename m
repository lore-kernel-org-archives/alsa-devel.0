From: Joe Hsu <nagual.hsu@gmail.com>
Subject: about bt878/879
Date: Wed, 30 Mar 2005 18:48:26 +0800
Message-ID: <7fe205990503300248217fab8@mail.gmail.com>
Reply-To: Joe Hsu <nagual.hsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

    I have a sound device which only offer bt878 digital audio at sample
rate 8000 HZ.  I modify the 'btaudio' module source( an OSS driver) and
then it works. But when I want to capture data from bt878 and play it 
back on AC97 codec in real time, underrun condition happens.(AC97)

    I've tried to modify the bt87x driver(alsa) to work for me but 
I apparently do not have the ability to make it work. Then I write 
a simple driver for bt878 and it works as follows:
    1. Allocate a fixed-size audio buffer
    2. Write audio raw data to that audio buffer in a circular way.
       (This also includes a write pointer to indicates the current 
       location in which the bt878 RISC program is writing data.)
    3. AP can mmap that buffer and read the value of the write pointer.

    I've tried that simple driver with storing raw audio data in the 
harddisk and then play it back later on AC97 codec(ALSA driver) with no
problem. But here comes the problem again when I try to capture data
and play it back in real time( still buffer underrun). I've used
interrupt-driven model in my program for playback. At first, the 
frames I captured and the available space(snd_pcm_avail_update) 
for playback is almost the same( or at a fixed difference). But after
few seconds, the available space for playback is larger and larger.
(The increasing rate is 1 frame every 1/125 second. One frame is 4
bytes long.) And I am quite sure I did not miss any capture data.

    Any one here can give some hints about this? I know full duplex
for same audio codec is already possible for ALSA. But when it comes
to two different audio codecs(apparently have different crystal clocks),
how can we record and playback in real time???
    Plz help. thanks.

    

-- 
The sun is shinny but the ice is slippery.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
