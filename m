From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Tue, 22 Jun 2004 14:48:45 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D87F0D.5020703@joe-job.com>
References: <1087416890.25102.21.camel@debian>	<1087704381.805.20.camel@debian>	<s5h3c4oncuh.wl@alsa2.suse.de>	<s5h1xk8nbxu.wl@alsa2.suse.de>	<1087849237.8161.38.camel@debian> <s5h8yefn8vu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yefn8vu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 21 Jun 2004 16:20:38 -0400,
> Lee Revell wrote:
> 
>>The capture will be driven by the playback interrupts (I think
>>EFX_BUFFER(HALF)FULL).  This would look very similar to the 
>>interrupt handler example #2 in your ALSA driver guide, which 
>>uses timer interrupts to drive the capture/playback, except 
>>that for playback, in addition to calling snd_pcm_period_elapsed()
>>on the playback substream, we also maintain a pointer to the 
>>corresponding *capture* substream, and call snd_pcm_period_elapsed() 
>>on it, manually tracking the frames processed in the same way the timer
>>interrupt example does.
> 
> 
> Even if we ignore the capture interrupts and use an additional
> interrupt source (e.g. an extra playback stream), the size of capture
> buffer still must follow the restriction.  That is, the minimal
> capture buffer size is still 384 x 2 bytes, although the period size
> can be set independently to smaller than 384 bytes. 
> 

Doesn't matter.  The inputs and outputs are GPR-mapped, so if we connect
a physical input to an FXBus channel, that FXBus channel will see the
exact samples that are arriving from that input, with zero latency.  If
the FXBus channel did not get filled with data until the capture buffer
was half full, you would be correct.

This solution will not allow low latency capture directly from the
physical input, it only works for the FXBus channels.

One correction to my design:  The handler for IPR_EFXBUFFER(HALF)FULL
is not where we need to call snd_pcm_period_elapsed on the capture
stream, it is IPR_CHANNELLOOP.

Lee


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
