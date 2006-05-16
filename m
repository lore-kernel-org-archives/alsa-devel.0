From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Doubt on implementing .readi and .readn methods
Date: Tue, 16 May 2006 18:17:14 -0300
Message-ID: <446A415A.5070505@instant.com.br>
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

Takashi Iwai wrote:

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
OK, let me see if I get this straight. My main concern here is how I 
have to do the implementation of _readn(). Let's suppose the raw file 
has the following 16-bit words in it: A, B, C, D, E, F, G, H, I...

After performing the _readn(), the memory ponted to by buf[0] to buf[3] 
(four channels) will have to contain the following 16-bit words:

buf[0] -> A, E, I, ...
buf[1] -> B, F, J, ...
buf[2] -> C, G, K, ...
buf[3] -> D, H, L, ...

So, I'll have to read from the file to a temporary buffer and do the 
juggling of the words (each consisting of (pcm->sample_bits >> 3) 
bytes). Check?

Juan


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
