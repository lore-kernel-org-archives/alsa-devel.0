From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa pulse bugs
Date: Wed, 07 May 2008 02:45:57 +0100
Message-ID: <fvr1kl$m4$1@ger.gmane.org>
References: <20080505103410.zv8dezd9z44cksoc@dbservice.com>
	<20080506193616.GB25436@tango.0pointer.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20080506193616.GB25436@tango.0pointer.de>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pulseaudio-discuss@mail.0pointer.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cross posting Lennart's reply to the Alsa list as requested.

Please can you guys apply #3942 and #3944 (see below), as per Lennart's 
recommendations?

Cheers :)

Col

Lennart Poettering wrote:
> On Mon, 05.05.08 10:34, tom@dbservice.com (tom@dbservice.com) wrote:
> 
>> I reported three bugs to the alsa bugtracker:
>>
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3942
> 
> I though I already posted a patch like this a while back. This really
> should be merged!
> 
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3943
> 
> This is not correct. snd_pcm_delay() is the delay that it takes until
> a sample you write now to the PCM stream takes to be played. For PCI
> devices this is usually the same as write_index-read_index, but not
> for virtual devices like PA, and not even for USB.
> 
> This is the only way snd_pcm_delay() has any value for synchronization
> purposes (i.e. syncing video to audio).
> 
> I think there's simply in invalid assumption made by the WINE devs (or
> possible even the MS devs who designed the API): they assume that all
> sound cards are PCI sound cards. Which ain't really true.
> 
> In short: the transport latency *needs* to be taken into account,
> there is no way around this.
> 
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3944
> 
> This looks good to me and should also be applied.
> 
> Could you please post the patch for 3942 and 3944 to the ALSA ml? The
> truth is that the ALSA devs are very good at ignoring the ALSA BTS. If
> you want your stuff merged, post it to the ALSA ML, don't bother with
> the BTS.
> 
> And thank you very much for your patches!
> 
> Lennart
> 
