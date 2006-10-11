From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ALSA snd_xferi_t buffer arrangment
Date: Wed, 11 Oct 2006 16:19:44 +0100
Message-ID: <452D0B90.4050407@superbug.co.uk>
References: <B9FFC3F97441D04093A504CEA31B7C41E4E041@msilexch01.marvell.com>	<452D0726.9090604@superbug.co.uk>
	<s5hwt76khkh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwt76khkh.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Rita Shtern <rita@marvell.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 11 Oct 2006 16:00:54 +0100,
> James Courtier-Dutton wrote:
>> Assaf Hoffman wrote:
>>> Hi,
>>> Thanks again for clear answers.
>>> In case the HW strip the IEC958 frames, where the ALSA stack expect to
>>> find the various frame data fields such as perr, valid bit, audio
>>> sample, user data and channel status? Is there a data structure the HW
>>> should follow when DMAing the striped data to the DRAM buffer?
>>> What do you think of such acceleration? Does this saves a significant
>>> CPU time processing the ICE958 frames?
>>> Many thanks.
>>> P.S.
>>> I was looking into the ASLA stack and I could find
>>> SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_XX only in snd_pcm_hardware structure
>>> initialization. I could not see where it is used to tell the ALSA to
>>> process the data as IEC958 frames.
>>>
>> A majority of sound cards strip the frame, and only put the audio
>> samples in the DMA buffer. The sound card then stores the valid bits,
>> non-audio bit, user data etc. in a separate register on the sound card.
>>
>> The processing of the IEC958 frames is done in alsa-lib.
>> ALSA has two parts, and kernel part, and a user space lib.
>> The kernel part does as little as possible, with the user space part
>> doing all the format conversion etc.
>>
>> I have not looked closely, but I don't know if the alsa-lib decodes the
>> IEC958 frames or not yet.
> 
> It can.  iec958 plugin does encode/decode IEC958 frames.
> 
> 
> Takashi

Does it let the user app set the valid, non-audio etc. bits?


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
