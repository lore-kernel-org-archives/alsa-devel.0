From: Zsolt Barat <barat@medien.uni-weimar.de>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 17:13:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110FCFE.4050409@medien.uni-weimar.de>
References: <200408041301.i74D1omu022274@localhost.localdomain> <4110E53A.8060202@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4110E53A.8060202@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: lists@wildgooses.com
List-Id: alsa-devel@alsa-project.org

Ed Wildgoose wrote:

> Basically, I set 1024 as the period size first (since this seems a 
> reasonable size), then set periods to be "near" 16, however, the 
> driver tells me that I can only have 2.  But at this point I can't go 
> back and bump up the period size to 8192 or similar.
>
> Actually just to be clear and avoid confusion, if I try on the RME9632 
> to set period size to be "near" 8192 right at the start then I just 
> get 2048.  Very peculiar.
>
>
just in case you didn't noticed you already can set different setups for 
some periods (frags) and periodsizes. it would be triggered by the -abs 
option in mplayer. it isn't documented i know.

      switch (ao_data.buffersize)
    {
    case 1:
      alsa_fragcount = 16;
      chunk_size = 512;
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: buffersize set manually to 
8192\n");
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: chunksize set manually to 512\n");
      break;
    case 2:
      alsa_fragcount = 8;
      chunk_size = 1024;
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: buffersize set manually to 
8192\n");
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: chunksize set manually to 
1024\n");
      break;
    case 3:
      alsa_fragcount = 32;
      chunk_size = 512;
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: buffersize set manually to 
16384\n");
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: chunksize set manually to 512\n");
      break;
    case 4:
      alsa_fragcount = 16;
      chunk_size = 1024;
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: buffersize set manually to 
16384\n");
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: chunksize set manually to 
1024\n");
      break;
    default:
      alsa_fragcount = 16;
      if (ao_mmap)
        chunk_size = 512;
      else
        chunk_size = 1024;
      break;
    }
    }

fragcount is periods here and chunksize is periodsize (could be reanamed 
probably).

btw. could you send me your changes you made?

regards

Zsolt




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
