From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 03:21:55 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110317080.5612-100000@ecabase.localdomain>
References: <20030711000049.GA21433@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030711000049.GA21433@alinoe.com>
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

On Fri, 11 Jul 2003, Carlo Wood wrote:

>> Total number of fragments allocated for buffering: 64
> Well, you have 64 fragments - I only 2.

Yup, that's because I'm using the snd-ens1371 driver (maximum interrupt 
frequency ~= period size, is driver/card dependent).

>> #fragments, #bytes: 13, 13472
>> Read 1024 bytes.
> You didn't really test it when you stop here.
> 13472 < 64 * 1024.

I increased the size of the loop and eventually managed to reproduce the
same behaviour you are seeing. It happens somewhere around 100-200th
iteration. Hmm, looks strange. I manage to workaround this by change the
test code to:

--cut--
      printf("Read %d bytes.\n", rlen);
      }
    else {
      static struct timespec naptime = { 0, 100000000 };
      nanosleep(&naptime, 0);
    }
--cut--

... hmm, anyways, it's 3:30am already here, so I'll have to call it a day
now.  Good luck in bug hunting, hopefully you can find out the cause.

> You need to wait till you get an overrun (xrun?).

Yups, xruns is a common (ALSA) term for underruns and overruns.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
