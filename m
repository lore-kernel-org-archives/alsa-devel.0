From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] aoss32 fails with TeamSpeak
Date: Wed, 07 Dec 2005 17:13:22 -0500
Message-ID: <1133993603.17901.103.camel@mindpipe>
References: <4391DABA.9010408@dbservice.com>
	 <200512072114.28179.trapni@gentoo.org> <1133986970.17901.52.camel@mindpipe>
	 <200512072139.51191.trapni@gentoo.org> <1133987628.17901.61.camel@mindpipe>
	 <4397568C.9040300@dbservice.com> <439758E2.8050603@dbservice.com>
	 <1133989080.17901.74.camel@mindpipe> <43975E15.9000803@dbservice.com>
	 <1133990607.17901.86.camel@mindpipe> <43976586.2070009@dbservice.com>
	 <1133992082.17901.95.camel@mindpipe>  <43976A9A.4080202@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43976A9A.4080202@dbservice.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tomas Carnecky <tom@dbservice.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-12-07 at 23:04 +0000, Tomas Carnecky wrote:
> Lee Revell wrote:
> 
> > I believe this is because dmix defaults to S16_LE, you have to add a
> > "format S32_LE" line somewhere for it to work.  Look at ICE1712.conf.
> > 
> 
> Yep.. the S23_LE is needed.. but ICE1712.conf doesn't contain the 
> default device.
> 
> I had my asoundrc like this

Argh, sorry... this is getting beyond my abilities...

tiwai, can you patch ICE1724.conf to use dmix by default?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
