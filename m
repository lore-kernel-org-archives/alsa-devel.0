From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Q: is the ALSA-lib API thread-safe
Date: Thu, 05 Aug 2004 08:31:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408051231.i75CVUt8027083@localhost.localdomain>
References: <Pine.HPX.4.33n.0408051203210.18069-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 05 Aug 2004 12:06:55 +0200."
             <Pine.HPX.4.33n.0408051203210.18069-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Daniel Schnell wrote:
>> is the ALSA-Lib-API thread-safe concerning the following scenario:
>>
>> in thread 1 the audio-processing takes place via snd_pcm_avail_update(),
>> snd_pcm_begin(), snd_pcm_commit(). In thread 2 I call the functions:
>> snd_pcm_hwsync(), snd_pcm_avail_update() to get the actual delay via
>> bufferframes - snd_pcm_avail_update().
>
>The snd_pcm_t* handle which you're using in both threads refers to one
>data structure in alsa-lib which isn't protected against concurrent
>accesses.

how true. its a bit ironic that one of the big advances of ALSA's
kernel code over OSS is the addition of thread safety, and that
another is the use of a user-space library to mediate access. the
combination of the two, however, eliminates thread safety :(



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
