From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: problem with "snd_pcm_hw_params_set_period_size_near"
Date: Sat, 27 Sep 2003 15:44:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F75A241.80003@superbug.demon.co.uk>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

if the buffer size has already been set to 16384, and the period_size is 
trying to be set to 8196, why do I get the following results: -

period_size=8196
dir=0;
err = snd_pcm_hw_params_set_period_size_near(this->audio_fd, params, 
&period_size, &dir);
result: period_size=8196

period_size=8196
dir=1;
err = snd_pcm_hw_params_set_period_size_near(this->audio_fd, params, 
&period_size, &dir);
result: period_size=16384

In the second example, all that has changed in the value of "dir".
I though
-1 means find a value equal to or less than.
0 means find a value closest to.
1 means find a value equal to or greater than.

But the above experiment resulted in: -
1 means find a value greater than.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
