From: "超 李" <flyingwalter@msn.com>
Subject: Playing always at half of the rate of recording.
Date: Sun, 17 Nov 2002 22:44:48 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F9hQkQiijdhvs3qJSyl00011c5a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

Hi All,
  I'm using alsa library to write an application that play and record audio 
at the same time. I openned the default pcm device twice, and set params for 
them, nonblock, RW_INTERLEAVED, S16_LE format, 8000Hz, and 1 channel, the 
only difference is using SND_PCM_STREAM_CAPTURE for recording, and using 
SND_PCM_STREAM_PLAYBACK for playing.
  But the bytes played are always near half of the recorded, and the sound I 
heard is slowed comparing with its normal speed.
  My enviroment are:
  RedHat 7.3 / alsa 0.9.0 rc5 / linux kernel 2.4.18-3
  sound card module: via82xx

  How can I solve this?
  Thanks!

Walter


_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. 
http://join.msn.com/?page=features/virus



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
