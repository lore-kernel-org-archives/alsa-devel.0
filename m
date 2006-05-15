From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Doubt on implementing .readi and .readn methods
Date: Mon, 15 May 2006 17:31:38 -0300
Message-ID: <4468E52A.2020207@instant.com.br>
References: <4464E1B7.6070601@instant.com.br> <s5hac9jws8q.wl%tiwai@suse.de> <4468DF11.4000000@instant.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080809020405040405040701"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4468DF11.4000000@instant.com.br>
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

This is a multi-part message in MIME format.
--------------080809020405040405040701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some more info: Attached are my .asoundrc and the diff of the changes 
I've made to pcm_file.c.

Juan Carlos Castro y Castro wrote:

> Nice, that clears up a lot of doubts I had. Now I'd like to clear up a 
> few things in turn -- namely, what exactly I am trying to accomplish.
>
> I want to make a "sound bridge" -- Applications A and B both do sound 
> input and output, and I want A's sound output to become B's sound 
> input and vice versa. Call it the Acoustic Coupler From Hell if you 
> may. ;) If the file plugin did emulate sound input via file as well as 
> it does sound output, I'd be all set.
>
> Now comes the tricky part. I put debug messages in the .readi and 
> .readn functions in the file plugin, called arecord using that PCM 
> (which works fine as output, i.e., with aplay) as a source and... NONE 
> of that functions EVER get called! It's not a library installation 
> problem -- debug messages in the open function do get shown.
>
> That got me baffled. I imagined some polling problem, but I use the 
> null plugin as a slave, and that one always has bytes available. I'm 
> pretty sure I'm doing something stupid due to lack of familiarity with 
> the ALSA architecture. The question is, what?
>
> Cheers,
> Juan
> P.S.: By the way, how many people here would find this functionality a 
> nice thing to have? (Besides me of course)
>
> Takashi Iwai wrote:
>
>> At Fri, 12 May 2006 16:27:51 -0300,
>> Juan Carlos Castro y Castro wrote:
>>
>>> I'm a bit confused about what "areas" and "frames" are supposed to 
>>> mean, and in which order the data pointed to by **bufs corresponds 
>>> to the data that's written to disk in the .writen functions. I tried 
>>> to follow the logic in the functions  snd_pcm_areas_from_buf(),  
>>> snd_pcm_areas_from_bufs(), snd_pcm_file_add_frames(), and 
>>> snd_pcm_areas_copy(), and it feels like a labyrinth.
>>
>> "area" refers to snd_pcm_channel_area_t.  It's an exported struct
>> defined in pcm.h:
>>
>> /** PCM area specification */
>> typedef struct _snd_pcm_channel_area {
>>     /** base address of channel samples */
>>     void *addr;
>>     /** offset to first sample in bits */
>>     unsigned int first;
>>     /** samples distance in bits */
>>     unsigned int step;
>> } snd_pcm_channel_area_t;
>>
>> An area array is used for a stream with multiple channels.  Each
>> element of the array contains the area information for one channel.
>> For example, in the case of 16bit 4-channel interleaved format,
>>
>>     area[*].addr = base_addr
>>     area[0].first = 0
>>     area[1].first = 16
>>     area[2].first = 32
>>     area[3].first = 48
>>     area[*].step = 64
>>
>> "frame" is the unit of samples, and 1 frame = sample-width * chanenels.
>> e.g. for 16bit 4-channel format, 1 frame = 2 * 4 = 8 bytes.
>>
>>> Another thing, are the .readi and .readn functions supposed to 
>>> block, or can they return less bytes (frames?) than requested?
>>
>> Yes if opened without O_NONBLOCK flag.
>>
>> Takashi 
>

--------------080809020405040405040701
Content-Type: application/x-gzip;
 name="coupler.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="coupler.tgz"

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
AAA=
--------------080809020405040405040701--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
