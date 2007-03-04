From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 20bit PCM in 32 bit container
Date: Sun, 4 Mar 2007 16:39:53 +0100
Message-ID: <20070304163953.044b8a29.pochini@shiny.it>
References: <9c1cad6e0703031535m18d7a93fp6d1c0925893ba7d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <9c1cad6e0703031535m18d7a93fp6d1c0925893ba7d6@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Maen Suleiman <maen.suleiman@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 4 Mar 2007 01:35:28 +0200
"Maen Suleiman" <maen.suleiman@gmail.com> wrote:

> Hi ,
> 
>  My hardware uses a 20bit PCM format packed in 32bit, ,  I am using a
> 2.6.12 kernel and such a format doesn't exist, is the following enough
> for defining this format:
> 
>  1) defning a new value in 'enum sndrv_pcm_format'
>  2) adding new entry to pcm_formats[SNDRV_PCM_FORMAT_LAST+1] array
> that describes the new format .
> 
> 	[SNDRV_PCM_FORMAT_S20_NEW_LE] = {
> 		.width = 20, .phys = 32, .le = 1, .signd = 1,
> 		.silence = {},
> 	},

I suggest SND_PCM_FORMAT_S20_LE (ie. 20 bits signed data right-aligned in 32
bits frame). I never had a serious look at that code, but you at least also
have to add a lot of conversion functions to/from S20_LE in
alsa-lib/src/pcm/plugin_ops.h (look for #ifdef CONV_LABELS) which are used
by alsa-lib/src/pcm/pcm_linear.c:snd_pcm_linear_convert() and by many other
plugins.


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
