From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Tue, 22 Jun 2004 16:26:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D895EB.6040103@joe-job.com>
References: <1087416890.25102.21.camel@debian> <1087704381.805.20.camel@debian> <s5h3c4oncuh.wl@alsa2.suse.de> <s5h1xk8nbxu.wl@alsa2.suse.de> <1087849237.8161.38.camel@debian> <s5h8yefn8vu.wl@alsa2.suse.de> <Pine.LNX.4.58.0406221327270.1936@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 5D92B252
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2004 22:25:24 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0406221327270.1936@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> On Tue, 22 Jun 2004, Takashi Iwai wrote:
> 
> 
>>At Mon, 21 Jun 2004 16:20:38 -0400,
>>Lee Revell wrote:
>>
>>>The capture will be driven by the playback interrupts (I think
>>>EFX_BUFFER(HALF)FULL).  This would look very similar to the 
>>>interrupt handler example #2 in your ALSA driver guide, which 
>>>uses timer interrupts to drive the capture/playback, except 
>>>that for playback, in addition to calling snd_pcm_period_elapsed()
>>>on the playback substream, we also maintain a pointer to the 
>>>corresponding *capture* substream, and call snd_pcm_period_elapsed() 
>>>on it, manually tracking the frames processed in the same way the timer
>>>interrupt example does.
>>
>>Even if we ignore the capture interrupts and use an additional
>>interrupt source (e.g. an extra playback stream), the size of capture
>>buffer still must follow the restriction.  That is, the minimal
>>capture buffer size is still 384 x 2 bytes, although the period size
>>can be set independently to smaller than 384 bytes. 
> 
> 
> You can do lowlatency even with huge ring buffer, if you have a good
> interrupt / scheduling timer, but it requires changes in application.
> 

This is why I suggested adding an additional hardware device (it
would be hw:x,3), rather than modifying the current one, so that 
applications which expect the current behavior will not break.

I believe that the current driver does not support direct
capture/playback of the FXBus channels - the current FX8010/EFX device
just exposes the GPR-mapped FX8010 outputs, and is apparently just used
for AC3 passthrough.

Lee


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
