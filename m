From: "Mitul Sen (misen)" <misen@cisco.com>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
	let	me apply hardware parameters
Date: Tue, 1 Jul 2008 11:42:27 -0700
Message-ID: <3B6F5C9068D5864096EB291236C3386F03B35428@xmb-sjc-21d.amer.cisco.com>
References: <3B6F5C9068D5864096EB291236C3386F02CE1628@xmb-sjc-21d.amer.cisco.com>
	<486A384B.6090103@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 10FBC24458
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 20:43:17 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Thanks for your suggestions. For the first suggestion, how would I know the version of alsa-lib that I am using so that I can download the source code for the same? Is alsa-lib the same as libasound? Under /usr/lib/libasound.so I have a symbolic link to libasound.so.2.0.0. Is that then the version I should be looking for?

I am really new to this so please excuse me if these questions are too basic for this forum!

Thanks,
Mitul 


-----Original Message-----
From: stan [mailto:ghjeold_i_mwee@cox.net]
Sent: Tue 7/1/2008 6:59 AM
To: Mitul Sen (misen)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Setting format to SND_PCM_FORMAT_MU_LAW does not let	me apply hardware parameters
 
Mitul Sen (misen) wrote:
> I am a newbie to ALSA and any help will be much appreciated.
>
> I have an application which sets up the signaling between an IP phone
> and my desktop and then sets up the audio path between the two. 
>
> On my desktop application, I am able to receive RTP packets from IP
> phone. I use an RTP stack to parse the data and after going through the
> RTP stack, I try to play back the audio using ALSA. When I use the ALSA
> code to play back (in real time) using sound card of my device, there is
> only noise, I cannot hear the audio that I speak into the IP phone.
> However, if I take the raw data coming from the RTP stack and write it
> to a file, I can play back the file successfully.
>
> Since my data from IP phone is G.711 encoded, I have set the sampling
> rate within ALSA to 8000. Also I am using one source (mono) and
> non-interleaved data option for preparing ALSA for playback. When I set
> the format to SND_PCM_FORMAT_MU_LAW, at runtime it lets me set that
> format ie. snd_pcm_hw_params_set_format (for SND_PCM_FORMAT_MU_LAW) is
> successful. However I get a runtime error while applying the hardware
> parameters using snd_pcm_hw_params(..) if the format set earlier is
> SND_PCM_FORMAT_MU_LAW. Using any other format like SND_PCM_FORMAT_U8 or
> SND_PCM_FORMAT_S8, lets me apply the hardware parameters but it gives
> the problem of the noise (no "audible" voice) that I described earlier.
>   
This sounds like there is a mismatch in the data.  Two suggestions.

Look at the code that implements SND_PCM_FORMAT_MU_LAW in alsa-lib
and make sure it is correct (or actually there and not a stub).  See if 
there is some
other parameter(s) you have to set in order for it to function.

Write the output being sent to alsa-lib to a file as you are sending it 
and compare it
to the raw data you have captured that plays OK.  You want it to be the 
same.  If it
isn't, that is your problem.  If it is, the problem is in the alsa-lib 
decoding for this case.
Obviously, the coding must work in some case, because you are playing the
raw data successfully.  Either the application or alsa is decoding it 
successfully.  Compare
the successful decoding process with the unsuccessful decoding process.
