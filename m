From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: rsnd: care DMA slave channel name for DT
Date: Tue, 10 Jun 2014 21:02:45 +0300
Message-ID: <20140610180245.GA12361@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B74F2654C9
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 20:03:09 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hello Kuninori Morimoto,

The patch 199e7688bdf7: "ASoC: rsnd: care DMA slave channel name for
DT" from May 22, 2014, leads to the following static checker warning:

	sound/soc/sh/rcar/core.c:318 rsnd_dma_of_name()
	error: buffer overflow 'mod' 4 <= 4

sound/soc/sh/rcar/core.c
   278          struct rsnd_mod *mod[MOD_MAX];
   279          struct rsnd_mod *src_mod, *dst_mod;
   280          int i, index;
   281  
   282  
   283          for (i = 0; i < MOD_MAX; i++)
   284                  mod[i] = NULL;
   285  
   286          /*
   287           * in play case...
   288           *
   289           * src -> dst
   290           *
   291           * mem -> SSI
   292           * mem -> SRC -> SSI
   293           * mem -> SRC -> DVC -> SSI

I don't understand what this comment means.

   294           */
   295          mod[0] = NULL; /* for "mem" */

We memset everything to NULL in the loop above so this isn't needed.

   296          index = 1;
   297          for (i = 1; i < MOD_MAX; i++) {
   298                  if (!src) {
   299                          mod[i] = ssi;
   300                          break;
   301                  } else if (!dvc) {
   302                          mod[i] = src;
   303                          src = NULL;
   304                  } else {
   305                          mod[i] = dvc;
   306                          dvc = NULL;
   307                  }
   308  
   309                  if (mod[i] == this)
   310                          index = i;

In theory, index can be MOD_MAX - 1.

   311          }
   312  
   313          if (is_play) {
   314                  src_mod = mod[index - 1];
   315                  dst_mod = mod[index];
   316          } else {
   317                  src_mod = mod[index];
   318                  dst_mod = mod[index + 1];

So then it complains that mod[] has only MOD_MAX elements so we're one
space past the end of the array.  Probably the way this is called, there
is something to prevent it?

   319          }

regards,
dan carpenter
