From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Revo 7.1 setup ?
Date: Sat, 03 Dec 2005 14:28:02 -0500
Message-ID: <1133638082.16836.16.camel@mindpipe>
References: <1133636889.4274.7.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1133636889.4274.7.camel@rousalka.dyndns.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nicolas.mailhot@laposte.net
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-12-03 at 20:08 +0100, Nicolas Mailhot wrote:
> Hi,
> 
> I'm trying to setup a revo 7.1 in digital out mode (will do 5.1 analog
> whenever I receive Y cables).
> 
> After much googling the best asoundrc setting I found is :
> 
> pcm.!default {
>         type plug
>         slave.pcm "spdif"
> }

That .asoundrc does nothing that you could not do by setting the app to
use the "spdif" PCM - it's useless.

If you get no sound at all without an .asoundrc it's a bug, please file
a bug report:

https://bugtrack.alsa-project.org/alsa-bug/main_page.php

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
