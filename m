From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: hdsp + multiface bug (and other problems)
Date: Tue,  4 Jun 2002 11:36:45 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206041836.LAA21817@cmn29.stanford.edu>
References: <Pine.LNX.4.44.0206011534520.27650-100000@cmn24.stanford.edu>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0206011534520.27650-100000@cmn24.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: nando@ccrma.Stanford.EDU, gary@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi all, Gary Scavone here at ccrma is trying to use the
hdsp+multiface combo in his stk synthesis toolkit software and
is having some problems:

Gary wrote:
> In summary:
>
> Multiface specific:
> -------------------
>
> - OSS compatability doesn't seem to work
> - multiface reports 10 channels minimum on output, but it should be 18
> - multiface doesn't report a sample rate of 32000, though the docs
>   indicate it should be supported
>
> If you attempt to use 10 channels (as reported), the next
> snd_pcm_hd_params_set_xxxx call (sample rate in my case) fails.

I'm also copying some generic alsa library related stuff...

> ALSA library:
> -------------
>
> - second time through routine error report when setting Interleaved
> mode on Delta 66

> I have a routine which attempts to open a device with a set of
> parameters.  My program calls this routine on the available devices
> until it finds one that works.  In this particular case, our first
> device is the hdsp+multiface system and the second device is a Midiman
> Delta 66.  I am only referring to attempts at output for the moment.
>
> If I attempt to open the Midiman first, no problem.  If I attempt to
> open the RME card and that fails, an error occurs during the next call
> to the routine for the Delta 66.  Specifically, an error is reported
> when I attempt to set the Delta 66 for SND_PCM_ACCESS_RW_INTERLEAVED
> access although the configuration shows that the access is set
> correctly.  If I ignore the reported error, the audio output works
> fine.
>
> - documentation/actual behavior discrepancy for the
>   snd_pcm_hw_params_test_access() function
>
>  int snd_pcm_hw_params_test_access  (   snd_pcm_t *   pcm,
> snd_pcm_hw_params_t *   params,          snd_pcm_access_t   val     )
>
> is supposed to return a 1 if the access is available and zero
> otherwise.  But it actually returns a 0 if available and negative
> error code if not.

-- Fernando

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
