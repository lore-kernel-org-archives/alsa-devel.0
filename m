From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp vs 16bit vs dmix
Date: Mon, 26 Jan 2004 13:57:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40150EB7.8070907@undata.org>
References: <3FFC41E9.3050501@boosthardware.com> <s5hn08yznzf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn08yznzf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote :
>>
>>------
>>  aplay -f cd -D default audio.wav
>>ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS 
>>failed: Device or resource busy
>>ALSA lib pcm_direct.c:712:(snd_pcm_direct_initialize_slave) unable to 
>>install hw params
>>ALSA lib pcm_dmix.c:827:(snd_pcm_dmix_open) unable to initialize slave
>>aplay: main:502: audio open error: Device or resource busy
> 
> 
> hmm, it's wierd.  -ENODEV ?
> 

Old thread, but I missed it then. Indeed the dmix plugin doesn't play 
nicely with the hdsp.
The above give -ENODEV because if you don't specify 'channels 18' (for a 
multiface) in the dmix slave definition, the way the hw param settings 
is done tries to switch the card to double speed mode (there are less 
channels then, I guess it's closer to the 2 channels requested).
You should have the following in your logs :
cannot change speed mode (capture PID = -1, playback PID = 3888)

Now if you do specify 'channels 18' in the dmix slave definition, the 
error is as follows :
aplay: set_params:827: Sample format non available
I have 'format S32_LE' set in the dmix slave definition, but it doesn't 
seem to be taken into account.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
