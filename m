From: Paul Davis <pbd@op.net>
Subject: Re: should i be able to abort in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Wed, 13 Feb 2002 13:10:44 -0500
Message-ID: <200202131815.NAA15651@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA23179
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 19:15:45 +0100
In-reply-to: Your message of "Wed, 13 Feb 2002 19:07:30 +0100."
             <Pine.LNX.4.31.0202131905050.495-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>     poll
>>     snd_pcm_mmap_begin();
>>     snd_pcm_mmap_commit();
>>     poll
>>     snd_pcm_mmap_begin();
>>     ... realize things have gone wrong ...
>>     snd_pcm_drop();
>>     snd_pcm_prepare();
>>     snd_pcm_start ();
>>     poll
>>     snd_pcm_mmap_begin();
>>     snd_pcm_mmap_commit();
>>
>> i would have expected snd_pcm_drop() to effectively shut down the
>> driver, or at least for snd_pcm_drop() and snd_pcm_prepare() to get it
>> back to a "pristine" state again.
>>
>> so, how should i handle such a condition?
>
>The described sequence should work. As Abramo stated, the new
>snd_pcm_mmap_begin() call is enough. 

that implies that the h/w is left running between the failure point
and the snd_pcm_mmap_begin() call, right? that would be bad - the
playback stream will contain data, and we will continue to hear it
will we clean up. the driver is set to *not* handle xruns by itself.


>				      What exactly fails?

after restarting, the audio stream is not in sync - it contains minor
crackles and clicks suggesting that the device driver doesn't really
know where the hw pointer is. the effect varies with the period size,
which reinforces my belief in what's gone wrong. this happens on both
the hammerfall and the trident, though the effect sounds a little
different on each one.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
