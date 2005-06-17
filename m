From: =?utf-8?b?ancsTGVl?= <jwstyle@gmail.com>
Subject: Re: time stamp and dmix
Date: Fri, 17 Jun 2005 00:31:02 +0000 (UTC)
Message-ID: <loom.20050617T020400-431@post.gmane.org>
References: <loom.20050616T025514-907@post.gmane.org> <Pine.HPX.4.33n.0506161005500.29005-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Thank you for reply Clemens.

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> jw,Lee wrote:
> > when I use "plughw:0,0", I get the clean sound.
> > But I uss "plug:dmixer", there is some noise..:)
> 
> Update alsa-lib, there have been many bugfixes in dmix.
> 
> > when I use "plughw:0,0", my app play sound profectly with
> > various mp3 file. but If I use "plug:dmixer" some mp3 file
> > play fast.
> 
> The "plug:" should automatically convert sample rates.  Which
> application is this?

--> The application is what I'm making now.. :)
I think aout this problem...and I got some clue..
- the problem(noisy and fast),when I use "plug:dmixer",
is something related with sampling rate. the symptoms looks like 
wrong sampling rate setting.

I use .asoundrc like this
--------------------------------
pcm.!default {
    type plug
    slave.pcm "dmixer"
}

pcm.dsp0 {
    type plug
    slave.pcm "dmixer"
}

pcm.dmixer {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"
        period_time 0
        period_size 1024
        buffer_size 9216
        rate 44100
    }
}

ctl.mixer0 {
    type hw
    card 0
}
---------------------------------
and I set the hw parameter like this,

if((err=snd_pcm_open(&hPlayback, pcm_name, stream, 0)) < 0 ){
  :
}
if((err=snd_pcm_hw_params_any(hPlayback, hw_params)) < 0 ){
   :
}
if((err=snd_pcm_hw_params_set_access(hPlayback, hw_params,
                      SND_PCM_ACCESS_RW_INTERLEAVED)) < 0){
   :
}

if( (err=snd_pcm_hw_params_set_format(hPlayback, hw_params, 
           SND_PCM_FORMAT_S16)) < 0){
   :
}

exact_rate = snd_pcm_hw_params_set_rate_near(hPlayback, hw_params,
                 &frequency_near, &dir);

if( (err=snd_pcm_hw_params_set_channels(hPlayback, hw_params, 
                g_aud_channel)) < 0){
   :
}

if((err=snd_pcm_hw_params_set_buffer_time_near(hPlayback, hw_params, 
              &buffer_time, &dir))<0){
   :
}

snd_pcm_hw_params_get_buffer_size(hw_params, &aud_b_size);
fprintf(stderr,"BUFFER_SIZE=%d\n", aud_b_size);

if((err=snd_pcm_hw_params(hPlayback, hw_params))<0){
   :
}

anything wrong?

I'll trying to update alsa-lib.
thanks Clemens


> Regards,
> Clemens
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> 






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
