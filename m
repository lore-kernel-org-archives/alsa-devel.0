From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Doubt on implementing .readi and .readn methods
Date: Mon, 15 May 2006 17:05:37 -0300
Message-ID: <4468DF11.4000000@instant.com.br>
References: <4464E1B7.6070601@instant.com.br> <s5hac9jws8q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hac9jws8q.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nice, that clears up a lot of doubts I had. Now I'd like to clear up a 
few things in turn -- namely, what exactly I am trying to accomplish.

I want to make a "sound bridge" -- Applications A and B both do sound 
input and output, and I want A's sound output to become B's sound input 
and vice versa. Call it the Acoustic Coupler From Hell if you may. ;) If 
the file plugin did emulate sound input via file as well as it does 
sound output, I'd be all set.

Now comes the tricky part. I put debug messages in the .readi and .readn 
functions in the file plugin, called arecord using that PCM (which works 
fine as output, i.e., with aplay) as a source and... NONE of that 
functions EVER get called! It's not a library installation problem -- 
debug messages in the open function do get shown.

That got me baffled. I imagined some polling problem, but I use the null 
plugin as a slave, and that one always has bytes available. I'm pretty 
sure I'm doing something stupid due to lack of familiarity with the ALSA 
architecture. The question is, what?

Cheers,
Juan
P.S.: By the way, how many people here would find this functionality a 
nice thing to have? (Besides me of course)

Takashi Iwai wrote:

>At Fri, 12 May 2006 16:27:51 -0300,
>Juan Carlos Castro y Castro wrote:
>  
>
>>I'm a bit confused about what "areas" and "frames" are supposed to mean, 
>>and in which order the data pointed to by **bufs corresponds to the data 
>>that's written to disk in the .writen functions. I tried to follow the 
>>logic in the functions  snd_pcm_areas_from_buf(),  
>>snd_pcm_areas_from_bufs(), snd_pcm_file_add_frames(), and 
>>snd_pcm_areas_copy(), and it feels like a labyrinth.
>>    
>>
>
>"area" refers to snd_pcm_channel_area_t.  It's an exported struct
>defined in pcm.h:
>
>/** PCM area specification */
>typedef struct _snd_pcm_channel_area {
>	/** base address of channel samples */
>	void *addr;
>	/** offset to first sample in bits */
>	unsigned int first;
>	/** samples distance in bits */
>	unsigned int step;
>} snd_pcm_channel_area_t;
>
>An area array is used for a stream with multiple channels.  Each
>element of the array contains the area information for one channel.
>For example, in the case of 16bit 4-channel interleaved format,
>
>	area[*].addr = base_addr
>	area[0].first = 0
>	area[1].first = 16
>	area[2].first = 32
>	area[3].first = 48
>	area[*].step = 64
>
>"frame" is the unit of samples, and 1 frame = sample-width * chanenels.
>e.g. for 16bit 4-channel format, 1 frame = 2 * 4 = 8 bytes.
>
>
>  
>
>>Another thing, are the .readi and .readn functions supposed to block, or 
>>can they return less bytes (frames?) than requested?
>>    
>>
>
>Yes if opened without O_NONBLOCK flag.
>
>
>Takashi
>
>  
>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
