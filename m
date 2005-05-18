From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to autoconfigure MIDI in liveCD?
Date: Wed, 18 May 2005 14:37:28 -0400
Message-ID: <1116441448.4866.6.camel@mindpipe>
References: <20050518183049.5841.qmail@web53604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050518183049.5841.qmail@web53604.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "airplays55@yahoo.com" <airplays55@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-05-18 at 11:30 -0700, airplays55@yahoo.com wrote:
> Knoppix 3.8 liveCD (which includes ALSA 1.0.8) loads
> the audio but not the midi portion of the soundcard. 
> In order to get the midi modules loaded (snd-seq-midi
> etc.), I have to manually run "alsaconf", which
> requires human intervention for me to accept the
> soundcard it found by probing, and also accepting the
> choice for alsaconf to modify /etc/modprobe.d/sound
> and /etc/modprobe.conf.

Before you think too hard, try the newest ALSA (1.0.9-rc3).  There was
some kind of bug in 1.0.8 where snd-seq-midi had to be loaded manually.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
