From: Marcus Andersson <054185595@telia.com>
Subject: Re: ALSA Hammerfall DSP driver
Date: Thu, 23 May 2002 22:00:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CED4A57.9E8EC888@telia.com>
References: <200205230411.GAA05795@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailb.telia.com (mailb.telia.com [194.22.194.6])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA17568
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2002 21:55:45 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> i have been using alsamixer to control the playback volumes, and it
> seems to work fine. amixer reports the values correctly as well, so
> try
> 
>     amixer cget numid=11  # channel 1 playback volume

numid=11,iface=MIXER,name='Chn',index=1
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=49818

>     amixer cget numid=17  # channel 2 playback volume

numid=17,iface=MIXER,name='Chn',index=2
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=49818

Still no sound.

Could it be that my kernel is too old? 2.4.7.

Could it be that I am using alsa-utils-0.9.0rc1? The one in CVS fails
with:

aclocal: configure.in: 11: macro `AM_PATH_ALSA' not found in library
CFLAGS=-O2 -Wall -pipe -g
./configure 
loading cache ./config.cache
./configure: line 526: syntax error near unexpected token
`AM_INIT_AUTOMAKE(alsa-utils,'
./configure: line 526: `AM_INIT_AUTOMAKE(alsa-utils, 0.9.0rc1)'


Is it possible to route sound to the line out port?

Which channel and card do the OSS layer use? How can I control this?

Marcus

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
