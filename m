From: Dino Puller <dino@e4a.it>
Subject: Re: Decibel]
Date: Tue, 15 Nov 2005 18:59:07 +0100
Message-ID: <437A21EB.4030107@e4a.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

James Courtier-Dutton wrote:

>On 14/11/05, Dino Puller <dino@e4a.it> wrote:
>  
>
>>Hi all,
>>  only a simple  question:  How to obtain min_dB value for my device or
>>pcm channel? I found the api snd_mixer_selem_get_playback_dB_range but i
>>didn't understand how to use it. Is it the right api? I've found also
>>sndo_mixer_io_get_dB i'm a bit confused.
>>
>>thanks,
>>  Dino Puller
>>
>>    
>>
>
>Those api commands are not supported yet. The alsa-lib to user
>application api is there and fixed. The support needs to be added to
>alsa-driver and some modifications to alsa-lib to make it work. I am
>working on it.
>
>James
>
>  
>
Ok. Any way i'm doing something very similar to pcm_softvol plugin and i 
want to make a conversion from linear to dB scale

here is the point:
(taken from pcm_soft_vol.c)
...
       svol->min_dB = min_dB;
       for (i = 1; i < svol->max_val; i++) {
           double db = svol->min_dB - ((i - 1) * svol->min_dB) / 
(svol->max_val - 1);
           double v = (pow(10.0, db / 20.0) * (double)(1 << 
VOL_SCALE_SHIFT));
           svol->dB_value[i] = (unsigned short)v;
       }
...

in this plugin the default min_dB value is -48 but the volume is too 
low, now witch value should i use? Is there a default value for a pcm 
channel?

thanks,
  Dino Puller








-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
