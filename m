From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 01:49:49 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110145380.5612-100000@ecabase.localdomain>
References: <20030710013326.GA12086@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030710013326.GA12086@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Jul 2003, Carlo Wood wrote:

> But, when compiling it with:
>   gcc -DUSE_DSP_SETFMT=1 troep.c
> It stops rather quickly with reading data.

Hmm, I tested on my machine and this seems to work fine (ALSA 0.9.3c 
/ 2.4.19 / SB128 (snd-ens1371 module).

> ~>a.out
> Fragment size: 1024
> Number of fragments: 32767
> Number of channels: 1
> Sample rate: 22050
> Read 1024 bytes.
> Number of full fragments that can be read or written without blocking: 0
> Total number of fragments allocated for buffering: 2
> Size of a fragment in bytes: 1024
> Number of bytes that can be read or written immediately without blocking: 0
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 1, 1632
> Read 1024 bytes.
> #fragments, #bytes: 2, 2048
> Read 1024 bytes.
> #fragments, #bytes: 1, 1024
> Read 1024 bytes.
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 0, 0

I get:
--cut--
Fragment size: 1024
Number of fragments: 32767
Number of channels: 1
Sample rate: 22050
Read 1024 bytes.
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 64
Size of a fragment in bytes: 1024
Number of bytes that can be read or written immediately without blocking: 
0
#fragments, #bytes: 0, 0
#fragments, #bytes: 1, 1696
Read 1024 bytes.
#fragments, #bytes: 2, 2432
Read 1024 bytes.
#fragments, #bytes: 3, 3168
Read 1024 bytes.
#fragments, #bytes: 3, 3904
Read 1024 bytes.
#fragments, #bytes: 4, 4640
Read 1024 bytes.
#fragments, #bytes: 5, 5376
Read 1024 bytes.
#fragments, #bytes: 5, 6112
Read 1024 bytes.
#fragments, #bytes: 6, 6848
Read 1024 bytes.
#fragments, #bytes: 7, 7584
Read 1024 bytes.
#fragments, #bytes: 8, 8320
Read 1024 bytes.
#fragments, #bytes: 8, 9056
Read 1024 bytes.
#fragments, #bytes: 9, 9792
Read 1024 bytes.
#fragments, #bytes: 10, 10528
Read 1024 bytes.
#fragments, #bytes: 11, 11264
Read 1024 bytes.
#fragments, #bytes: 11, 12000
Read 1024 bytes.
#fragments, #bytes: 12, 12736
Read 1024 bytes.
#fragments, #bytes: 13, 13472
Read 1024 bytes.
...
--cut--

More in the next post...

-- 
 http://www.eca.cx
 Audio software for Linux!




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
