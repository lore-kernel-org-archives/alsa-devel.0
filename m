From: Ryan Gammon <rggammon@helixcommunity.org>
Subject: [patch] Re: dmix, pause, and snd_pcm_delay
Date: Tue, 06 Jul 2004 23:08:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40EB9358.7020608@helixcommunity.org>
References: <40EA58EA.2080005@helixcommunity.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40EA58EA.2080005@helixcommunity.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Disabling hardware pause in dmix seems to solve my problems:

--- pcm_plug.c~ 2004-02-08 02:20:03.000000000 -0800
+++ pcm_plug.c  2004-07-06 22:58:24.000000000 -0700
@@ -848,7 +848,7 @@
        if (err < 0)
                return err;
        /* FIXME */
-       params->info &= ~(SND_PCM_INFO_MMAP | SND_PCM_INFO_MMAP_VALID);
+       params->info &= ~(SND_PCM_INFO_MMAP | SND_PCM_INFO_MMAP_VALID | 
SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME);
        return 0;
 }

Is this a reasonable fix?


Ryan Gammon wrote:

> Hi guys,
>
> I've been fooling around with the helix client media playback engine 
> from helixcommunity.org in combination with alsa-lib-1.0.4, with the 
> goal of getting audio playing back properly.
>
> My set-up looks something like this:
>
> ===============
> | Esound apps |
> ===============
>      ||
>      ||
> =================      ===================
> | Esound hacked |      | Helix Client w/ |
> | to work with  |      | ALSA support    |
> | dmix          |      ===================
> =================             /
>       \                    /
>         \                /
>         =======================
>         | dmix server running |
>         | in an esound forked |
>         | process             |
>         =======================
>                   ||
>                   ||
>           =================
>           | snd_usb_audio |
>           =================
>
>
> Esound apps here are mostly apps with an alsa implementation that's 
> not up to supporting dmix. This has the additional benefit of hosting 
> the alsa dmix server in a esound process, which is good, as dmix 
> doesn't seem to run properly if it's in a process forked from the 
> helix client. This might have something to do with the various threads 
> created by the client before opening the audio device, and the fact 
> that the dmix server doesn't exec after the fork, but I haven't really 
> looked too deeply into it.
>
> My main difficulty is in implementing the 
> CAudioOutUNIX::_GetBytesActualyPlayed (sic) function in the helix code 
> base. The goal of this function is to return the number of bytes that 
> have been played by the sound device. It is mostly used for ensuring 
> video and audio are synchronized.
>
> I've tried to implement this in a couple of different ways:
> 1. Using mmaped timestamps, and converting the time interval between 
> now and when playback triggered into bytes.
> 2. Using bytes_written - snd_pcm_delay()
> 3. Using bytes_written - (initial snd_pcm_avail_update() value - 
> current snd_pcm_avail_update() value
> 4. Using the snd_timer api (still figuring this out)
> 5. Something with snd_pcm_sync_id_t (not sure what this is, or how to 
> use it)
>
> I've run into various problems with all these methods.
>
> 1. I find that, while I get a valid timestamp from 
> snd_pcm_status_get_trigger_tstamp, snd_pcm_status_get_tstamp 
> consistantly gives me a timestamp of 0 s + 0 us.
>
> 2. This works well until I try to pause. dmix claims support for 
> hardware pause, but when I pause, the hw.ptr seems to keep marching 
> on, and when I unpause, snd_pcm_delay() returns a negative value, as 
> the hardware pointer has become greater than the software pointer.
>
> 3. Similar problem to (2) -- hw.ptr seems to get out of sync.
>
> 4. Not sure how to get playback and the timer to start at the same 
> time. Maybe I have to set the start threshold on the pcm device such 
> that I start playback manually, and start the timer at the same time 
> as playback? I'm also worried that there might be drift between the 
> timer and the PCM device when the timer isn't something that's on the 
> sound card. Dealing with overruns and underruns also seems like it 
> would be complicated here.
>
> 5. Not sure what snd_pcm_sync_id_t is nor how one would use it.
>
> Anyone have any tips or tricks? I'm willing to some poking around 
> alsa-lib if what I'm looking at here appears to be a dmix issue.
>
> Thanks,
>
> Ryan
>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
