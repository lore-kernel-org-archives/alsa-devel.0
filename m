From: Paolo Losi <p.losi@hypersonic.it>
Subject: Re: Event Based time synchronization with ALSA
Date: Tue, 18 Jan 2005 12:47:11 +0100
Message-ID: <41ECF73F.7070404@hypersonic.it>
References: <41EB9874.4060407@hypersonic.it> <41EBEB8F.9030009@gardena.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41EBEB8F.9030009@gardena.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benno Senoner <sbenno@gardena.net>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Benno,

	thank you very much for you response.
	
Benno Senoner wrote:
  > The above routine has the advantage that you can use any kind of
> periodsize (fragment size) in ALSA
> and the send_rtp packet() always gets 20msec worth of data.
> But you must ensure that the ALSA period size must be <20msec , 
> otherwise too much jitter is introduced.

I see your point.... but I would have two objections:
- I don't want/can't use threads
- I get too much jitter

If I make poll timeout every 20ms in the main loop,
I'm sure I get 20ms worth of data
so I can busy loop to reading (in blocking mode) all samples
(If I would want to enforced that period is power of two, I could
choose the max power of two number of samples that is divider of the 
required number of samples)
That would be 8000HZ sampling for 20ms => 160 sample per packet
=> 5 32samples reads

But I'd rather tell ALSA: "please wake up poll as soon as you have
160 samples available". Is that feaseble? Can I expect to be always
woken up?

How

snd_pcm_sw_params_set_avail_min
snd_pcm_sw_params_set_sleep_min
snd_pcm_sw_params_set_start_threshold  	

relates to my problem?

I tried to read the API doc but, since I've no experience with audio
programming, I didn't get all the points...

Can anyone point to a good poll based read example?

	thanks again benno!

	Paolo


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
