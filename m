From: Lenart Janos <ocsi@debian.org>
Subject: ca0106 (audigyls) driver: working in 5.1?
Date: Wed, 5 Jan 2005 22:54:46 +0100
Message-ID: <20050105215446.GA6777@elte.hu>
Reply-To: ocsi@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi!

I have a "Sound Blaster Live! 24 bit 7.1" soundcard. I am happily
reporting that analog output to two channels (simple stereo) is fully
working (at least for me) with the ca0106 (audigyls) driver.
However, I could not get it to work in 6 channels. I looked into the
code and got this from the main.c:

/* hardware definition */
static snd_pcm_hardware_t snd_ca0106_playback_hw = {
        ...
	.channels_min =		2,  //1,
	.channels_max =		2,  //6,
	.buffer_bytes_max =	(32*1024),
	.period_bytes_min =	64,
	.period_bytes_max =	(16*1024),
	.periods_min =		2,
	.periods_max =		8,
	.fifo_size =		0,
};

Hmm. Why is the comment for .channels_min and .channels_max? [Please
note that I definetly not kernel developer] I tried to change them to 1
and 6. No success. In this case, when I try to play anything in _not_ 2
channels it's seems too slow (the whole box, and the sound too) and
distorted. I found out ( ;) ), that I should increase the
.period_bytes_{min,max} too. I tried as I found in other driver, but no
success so far.
So.. the question is: does anyone have a ca0106 driver which works for
5.1 (I don't care with 7.1), or such just does not exists at all?

Thank you all, and please, do not forgot to Cc: me, as I am not
subscribed to this list!

Regards,
-- 
LENART, Janos
<ocsi@debian.org>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
