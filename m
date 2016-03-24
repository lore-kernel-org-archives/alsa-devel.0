From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: ASoC: TLV320AIC3x how to reduce alsa playback/capture
 latency?
Date: Thu, 24 Mar 2016 14:12:15 +0300
Message-ID: <56F3CB8F.8020109@mcsplus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp24.mail.ru (smtp24.mail.ru [94.100.181.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 19FF52669E5
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 12:12:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,
I have an issue to reduce playback/capture audio latency for AIC3106.
Now I'm using following strategy for initial of alsa backend driver in 
user level application:

snd_pcm_hw_params_set_period_size(...,frame_size,...);
snd_pcm_hw_params_set_periods_min(...,&periodsp,...);
if(periodsp< user_nperiods)
	periodsp = user_nperiods
snd_pcm_hw_params_set_periods_near(....,&periodsp,...);
snd_pcm_hw_set_buffer_size(...,frame_size*periodsp,....);
[...]
snd_pcm_sw_params_set_start_threshold(..., 0U);
snd_pcm_sw_params_set_stop_threshold(..., frame_size*periodsp);
if(playback)
{
	availmin=frame_size*(periodsp-user_nperiods+1);

}else
{
	availmin=frame_size;
}
snd_pcm_sw_params_set_avail_min(...,availmin)
[...]

On far end I hear an echo with delay about 1 second, I definitely know 
that it is a playback/capture (acoustic echo), and delay is too much for 
any AEC because of (as I think) low latency in alsa driver or 
misunderstanding how it should be initialized. I already exclude other 
delays (jitter delay, network delay)

My initial parameters: frame_size = 640, rate = 16000, user_nperiods = 
2, but after calling snd_pcm_hw_params_set_periods_min I got minimum 
periodsp = 16.
For these parameter buffer (16 buffers 40ms each) total length of buffer 
is 0.64 sec.

My question is how could I reduce this latency? May be some improvements 
which allow me to set up less then 16 buffers, or I did wrong 
initialization or is there any another internal buffer which make such 
long delay for echo?

Cheers,
Tim Karaldin
