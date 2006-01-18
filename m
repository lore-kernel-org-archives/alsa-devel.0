From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa-lib compatibility
Date: Wed, 18 Jan 2006 02:34:05 -0500
Message-ID: <1137569646.30140.1.camel@mindpipe>
References: <Pine.LNX.4.61.0601041006310.9321@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6EC7D158
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 08:34:14 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601041006310.9321@tm8103.perex-int.cz>
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

On Wed, 2006-01-04 at 10:12 +0100, Jaroslav Kysela wrote:
> Hi,
> 
> 	it seems that it is quite required (based on current LKML 
> discussion) to keep the alsa-lib compatibility with old drivers. Please, 
> keep in mind that for example renaming of control names will break using 
> old 2.6 kernel with new alsa-lib.
> 	The alsa-lib C code already checks for older drivers, but
> the extended configuration (like 5.1, s/pdif devices) in most cases
> changes a lot. We should add some runtime checks which driver version
> is running in XXXXX.conf files and apply the old behaviour if required.
> 
> 				Any comments?
> 						Jaroslav
> 

How do you propose we solve this problem:

/usr/lib/mozilla-firefox/firefox-bin: relocation
error: /usr/lib/libalsatoss.so.0: symbol
snd_pcm_hw_params_set_rate_near, version ALSA_0.9.0rc4 not defined in
file libasound.so.2 with link time reference

My apps are compiled against alsa-lib 1.0.9 but I have 1.0.11-rc2
installed.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
