From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Tue, 08 Apr 2003 14:07:19 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E925907.50307@boosthardware.com>
References: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www2.webhosting.cx (www2.webhosting.cx [207.44.198.86])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA32105
	for <alsa-devel@alsa-project.org>; Tue, 8 Apr 2003 07:20:36 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
>
> 
> And finally the dshare plugin (used standard stereo device and using left 
> and right channels separately):
> 
> pcm.dshare_left {
>         type dshare
>         ipc_key 6678293
>         ipc_key_add_uid yes
>         slave {
>                 pcm "hw:0,0"
>         }
>         bindings {
>                 0 0
>         }
> }
> 
> pcm.dshare_right {
>         type dshare
>         ipc_key 6678293
>         ipc_key_add_uid yes
>         slave {
>                 pcm "hw:0,0"
>         }
>         bindings {
>                 0 1
>         }
> }
> 

Using the above example I get this error.

  arecord -f cd -D plug:dshare_left
ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for 
symbol _snd_pcm_dshare_open
ALSA lib pcm.c:1802:(snd_pcm_open_conf) symbol _snd_pcm_dshare_open is 
not defined inside (null)
arecord: main:479: audio open error: No such device or address

I would also like to test out the alsa_jack plugin but cannot find a 
reference to it anywhere. Has it been removed temporarily?


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
