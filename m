From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Sun, 23 Jan 2005 00:49:05 +0000
Message-ID: <41F2F481.2000304@superbug.co.uk>
References: <1106091073.24484.60.camel@krustophenia.net>	 <s5hpt01tler.wl@alsa2.suse.de> <1106343921.3232.50.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106343921.3232.50.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2005-01-19 at 17:48 +0100, Takashi Iwai wrote:
> 
>>At Tue, 18 Jan 2005 18:31:12 -0500,
>>Lee Revell wrote:
>>
>>>As promised, here's an updated patch to add real multichannel playback
>>>support (and improved multichannel capture) to the emu10k1 driver.
>>>
>>>http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v001.patch
>>>
>>>Please test it and report any problems.  I am especially interested in
>>>any regressions that impact regular PCM playback (the hw:0,0 device).
>>
>>The new function looks great.
>>Let me know if you think the patch is mature enough to be merged.
>>
> 
> 
> OK, I have really fixed the voice allocator.  Synth, regular PCM, and
> multichannel PCM all tested and working.
> 
> http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v003.patch
> 
> Some users report they get massive xruns using the regular hw:0,0
> device.  I cannot reproduce the problem, but I will update the patch to
> make regular PCM playback work the old way.
> 
> Lee
> 

I am currently doing work on the P16V chip that is on the Audigy 2 sound 
cards. It will be able to capture and playback 4 stereo channels at the 
same time, at anything from 44.1 khz up to 192khz. It can also pass 
samples to and from the EMU10K2 DSP, but it transfers them in blocks of 
8 mono channels. e.g. DSP fxchannel 0-7 or 8-15 or 16-23 etc.
So, I think it would be better if the multichannel patch you are doing 
uses those groupings of channels for multichannel play/capture.

James



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
