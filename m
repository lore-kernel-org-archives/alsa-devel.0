From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack multi-channel and configurability patch
Date: Mon, 17 Feb 2003 18:05:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030217180527.61bf4571.mdeboer@iua.upf.es>
References: <20030217165312.7464ccdd.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030217165312.7464ccdd.mdeboer@iua.upf.es>
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

Hello Jaroslav,

Something else I need your advice on, is the full duplex operation.

When I try to run the latency test
./latency -c 2 -r 48000 -F FLOAT_LE -m 8192 -M 8192 -Pjack -Cjack -e

(btw, note the bug with the -f / -F flag!)

first of all, 

	snd_pcm_hw_params_get_period_time(p_params, &p_time, NULL);
	snd_pcm_hw_params_get_period_time(c_params, &c_time, NULL);

return bogus values. I don't know why... anyway, I remove the 
p_time==c_time comparison to move on.

second, the playback is never started, since the snd_pcm_link doesn't
work, so I start it by hand.

but then I get in XRUN immediately...

any suggestions?

Maarten


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
