From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: Re: Re: alsa error /dev/snd/pcmC1D1c failed: No such
 file or directory
Date: Sun, 21 Jul 2002 11:32:46 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207211129140.17385-100000@cmn24.stanford.edu>
References: <Pine.LNX.4.33.0207200913450.809-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA00809
	for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2002 20:33:20 +0200
In-Reply-To: <Pine.LNX.4.33.0207200913450.809-100000@pnote.perex-int.cz>
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


Yes, I know that you can determine the number of devices via the CTL
interface ... that's what I use.  But you cannot determine whether
those devices support input and/or output without actually attempting
to open them for playback or capture (please correct me if I'm wrong
about this).  So, if indeed you still need to open each device to
determine its capabilities (input and/or output channels, etc...),
then the previously mentioned error message should not be
automatically written.

Just to clarify, the device pcmC1D1c actually exists, as reported by 
the CTL interface.  However, it only supports output, not input.

--gary

On Sat, 20 Jul 2002, Jaroslav Kysela wrote:

>>On Fri, 19 Jul 2002, Gary Scavone wrote:
>>
>>> 
>>> ALSA lib pcm_hw.c:797:(snd_pcm_hw_open) open /dev/snd/pcmC1D1c failed:
>>> No such file or directory
>>> 
>>> 
>>> This message automatically gets output by the alsa library when you
>>> call snd_pcm_open with SND_PCM_STREAM_CAPTURE on a device which can
>>> only provide output (such as the second device of the ensoniq 1370).  
>>> Since you cannot probe a device's capabilities without opening it, it
>>> seems to me that the library should not automatically print this
>>> message to stderr (or stdout).  Rather, the user can check the return
>>> value of the call and get an error string if desired.
>>> 
>>> The current behavior is very confusing.
>>
>>You can determine the number of PCM devices via the CTL interface.
>>
>>						Jaroslav
>>
>>-----
>>Jaroslav Kysela <perex@suse.cz>
>>Linux Kernel Sound Maintainer
>>ALSA Project  http://www.alsa-project.org
>>SuSE Linux    http://www.suse.com
>>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
