From: Tim Goetze <tim@quitte.de>
Subject: Re: Alsa Programming Examples
Date: Sun, 9 Jun 2002 12:50:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206091143590.844-100000@summer.quitte>
References: <200206080926.25082.do1ypv@linux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA32450
	for <alsa-devel@alsa-project.org>; Sun, 9 Jun 2002 12:50:37 +0200
In-Reply-To: <200206080926.25082.do1ypv@linux>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Philipp Vollmer <vollmer.philipp@t-online.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Philipp Vollmer wrote:

>> it seems params == 0 when you're calling snd_pcm_hw_refine.
>Hello,
>
>Sorry but there is no codeline like snd_pcm_hw_refine in the example.
>I will send you the file as an attachment.

in your file:

  if ((playback_handle = snd_pcm_open (&playback_handle, "default", 
	SND_PCM_STREAM_PLAYBACK, 0)) < 0) {

snd_pcm_open returns 0 on success, *not* the pcm handle. have you
tried reading the docs yet ;) and haven't you wondered why you pass
the address of 'playback_handle' to snd_pcm_open()?

gcc warns you about this:

$ gcc -c how1.c 
how1.c: In function `main':
how1.c:11: warning: assignment makes pointer from integer without a
cast

and if you had endeavoured to read the sources of alsa-lib, you'd 
have discovered that (alsa-lib/src/pcm/pcm.c):

int snd_pcm_hw_params_any(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
{
  _snd_pcm_hw_params_any(params);
  return snd_pcm_hw_refine(pcm, params);
}

with all respect, i think you could have tried a little harder to find
the error.

tim



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
