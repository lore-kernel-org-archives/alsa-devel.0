From: Howard Abrams <abramsh@acm.org>
Subject: Re: Simple ALSA capture/playback example and help wanted
Date: Thu, 28 Mar 2002 22:19:13 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CA40761.3010408@acm.org>
References: <3CA3D05A.5060102@acm.org> <20020328220648.A18690@mlug.missouri.edu> <3CA3F61B.9080302@acm.org> <20020328234942.B18690@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000409050101080105090906"
Received: from gemini.voidstar.org (12-236-25-36.client.attbi.com [12.236.25.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA15438
	for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2002 07:20:20 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Rages <markrages@mlug.missouri.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000409050101080105090906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Mark Rages wrote:

> On Thu, Mar 28, 2002 at 09:05:31PM -0800, Howard Abrams wrote:
> 
>>Thanks Mark. I'll take a look at jack, but in the near-term, I
>>copied a sample from a link off your page. It must have been
>>from a earlier rev of the api, but it only required very minimal
>>changes to compile.
>>
>>The program I used was "A Minimal Full-Duplex Program", off the
>>page: http://www.op.net/~pbd/alsa-audio.html#duplexex
>>
> 
> Can you tell us what changes were required? It will help improve the
> documentation.


Sure, a diff is attached.


> Sorry, I don't have the expertise (or the appropriate soundcard)
> to help with your specific problem.
> 


Is Takashi Iwai on this list? He's credited in the source for the
driver. Anyone else have one of these cards?


h.

--------------000409050101080105090906
Content-Type: text/plain;
 name="diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.txt"

12c10
<          if ((snd_pcm_open ( &playback_handle, argv[1], SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
---
>          if ((playback_handle = snd_pcm_open (argv[1], SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
17c15
<          if ((snd_pcm_open ( &capture_handle, argv[1], SND_PCM_STREAM_CAPTURE, 0)) < 0) {
---
>          if ((capture_handle = snd_pcm_open (argv[1], SND_PCM_STREAM_CAPTURE, 0)) < 0) {
27c25
<          snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 44100, 0);
---
>          snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 44100);
35c33
<          snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, 44100, 0);
---
>          snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, 44100);
45,46c43,44
<                  snd_pcm_writei (playback_handle, pbuf, sizeof (pbuf));
<                  snd_pcm_readi (capture_handle, cbuf, sizeof (cbuf));
---
>                  snd_pcm_write (playback_handle, pbuf, sizeof (pbuf));
>                  snd_pcm_read (capture_handle, cbuf, sizeof (cbuf));
--------------000409050101080105090906--
