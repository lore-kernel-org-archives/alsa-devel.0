From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa-lib compatibility
Date: Wed, 18 Jan 2006 04:08:46 -0500
Message-ID: <1137575327.30140.7.camel@mindpipe>
References: <Pine.LNX.4.61.0601041006310.9321@tm8103.perex-int.cz>
	 <1137569646.30140.1.camel@mindpipe>
	 <Pine.LNX.4.61.0601180946050.9390@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DE9E1158
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 10:08:55 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601180946050.9390@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-01-18 at 09:48 +0100, Jaroslav Kysela wrote:
> On Wed, 18 Jan 2006, Lee Revell wrote:
> 
> > On Wed, 2006-01-04 at 10:12 +0100, Jaroslav Kysela wrote:
> > > Hi,
> > > 
> > > 	it seems that it is quite required (based on current LKML 
> > > discussion) to keep the alsa-lib compatibility with old drivers. Please, 
> > > keep in mind that for example renaming of control names will break using 
> > > old 2.6 kernel with new alsa-lib.
> > > 	The alsa-lib C code already checks for older drivers, but
> > > the extended configuration (like 5.1, s/pdif devices) in most cases
> > > changes a lot. We should add some runtime checks which driver version
> > > is running in XXXXX.conf files and apply the old behaviour if required.
> > > 
> > > 				Any comments?
> > > 						Jaroslav
> > > 
> > 
> > How do you propose we solve this problem:
> > 
> > /usr/lib/mozilla-firefox/firefox-bin: relocation
> > error: /usr/lib/libalsatoss.so.0: symbol
> > snd_pcm_hw_params_set_rate_near, version ALSA_0.9.0rc4 not defined in
> > file libasound.so.2 with link time reference
> 
> Hmm. It should work. The libasound.so.2 should have this symbol defined:
> 
> perex@tm8103:~/alsa/alsa-lib/src/.libs> nm libasound.so.2 | grep rate_near | grep rc4
> 00041460 T snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4
> 
> and the libalsatoss.0.0.0:
> 
> perex@tm8103:~/alsa/alsa-oss/alsa> nm .libs/libalsatoss.0.0.0  | grep rate_near
>          U snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4
> 
> Could you check it?
> 

I got different output.  But, I think the problem was I forgot to
install the newer alsa-oss.

$ nm /usr/lib/libasound.so.2.0.0 | grep rate_near
00044f63 t __old_snd_pcm_hw_params_set_rate_near
00040ff5 T __snd_pcm_hw_params_set_rate_near
00040ff5 W snd_pcm_hw_params_set_rate_near

$ nm /usr/lib/libalsatoss.so.0.0.0 | grep rate_near
         U snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4

Lee




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
