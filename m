From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 02:09:57 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110209040.5612-100000@ecabase.localdomain>
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

How about if you make the following change to the test:

--cut--
    printf("#fragments, #bytes: %d, %d\n", info.fragments, info.bytes);
-    if (info.fragments > 0)
-    {
      ssize_t rlen = read(fd, buf, sizeof(buf));
      if (rlen <= 0)
      {
	perror("read");
	exit(1);
      }
      printf("Read %d bytes.\n", rlen);
-    }
    static struct timespec naptime = { 0, 100000000 };
--cut--

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
