From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Audigy2 in SNDRV_PCM_FMTBIT_S32_LE mode.
Date: Tue, 18 May 2004 17:03:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40AA33C5.6090808@superbug.demon.co.uk>
References: <40AA2FF5.80700@superbug.demon.co.uk> <s5h3c5x3f5c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c5x3f5c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 18 May 2004 16:47:01 +0100,
> James Courtier-Dutton wrote:
> 
>>What would I need to change in the emu10k1 driver, to get alsa-lib to 
>>send it 32bit audio samples.
>>I tried just adding the SNDRV_PCM_FMTBIT_S32_LE to the playback options, 
>>but that did not work.
>>
>>When I did that, everything just played at half speed.
>>
>>Can anyone give me any pointers as to where else I should change things 
>>in order to get 32bit audio to the Audigy2 DSP.
> 
> 
> AFAIK, emu10k1 engine processes only 16bit PCM.
> or do you know the register (or anything else) to handle 32bit data
> for audigy?
> 
> 
> Takashi
> 
> 

The SB Live DSP can only handle 16bit PCM.
The SB Audigy DSP can handle 24/32 bit PCM.

I am working from what someone has told me to get 24bit sound. Send it 
to the Audigy inside a 32bit value: -
For playback:
You can use voice grouping - alloc 4 FX busses for 1 stereo stream
or use TRAM.

Does this help you ?


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
