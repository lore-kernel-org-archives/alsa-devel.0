From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 02:28:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030711002824.GB21433@alinoe.com>
References: <20030710013326.GA12086@alinoe.com> <Pine.LNX.4.44.0307110209040.5612-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307110209040.5612-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 11, 2003 at 02:09:57AM +0300, Kai Vehmanen wrote:
> How about if you make the following change to the test:
> 
> --cut--
>     printf("#fragments, #bytes: %d, %d\n", info.fragments, info.bytes);
> -    if (info.fragments > 0)
> -    {
>       ssize_t rlen = read(fd, buf, sizeof(buf));
>       if (rlen <= 0)
>       {
> 	perror("read");
> 	exit(1);
>       }
>       printf("Read %d bytes.\n", rlen);
> -    }
>     static struct timespec naptime = { 0, 100000000 };

That gives rather strange output:

Fragment size: 1024
Number of fragments: 32767
Number of channels: 1
Sample rate: 22050
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 1024
Number of bytes that can be read or written immediately without blocking: 0
#fragments, #bytes: 0, 0
Read 1024 bytes.  Average bytes/second read: 9579.135446
#fragments, #bytes: 2, 2048
Read 1024 bytes.  Average bytes/second read: 9833.483781
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 9906.130386
#fragments, #bytes: 0, 0
Read 1024 bytes.  Average bytes/second read: 8601.771175
#fragments, #bytes: 1, 1600
Read 1024 bytes.  Average bytes/second read: 8857.074156
#fragments, #bytes: 2, 2048
Read 1024 bytes.  Average bytes/second read: 9034.443817
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 9165.830174
#fragments, #bytes: 0, 0
Read 1024 bytes.  Average bytes/second read: 8631.080318
#fragments, #bytes: 1, 1632
Read 1024 bytes.  Average bytes/second read: 8768.366140
#fragments, #bytes: 2, 2048
Read 1024 bytes.  Average bytes/second read: 8881.310479
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 8975.563423
#fragments, #bytes: 0, 0
Read 1024 bytes.  Average bytes/second read: 8647.230571
#fragments, #bytes: 1, 1600
Read 1024 bytes.  Average bytes/second read: 8741.039482
#fragments, #bytes: 2, 2048
Read 1024 bytes.  Average bytes/second read: 8822.479599
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 8894.586984
#fragments, #bytes: 0, 0
Read 1024 bytes.  Average bytes/second read: 8655.099768
#fragments, #bytes: 1, 1600
Read 1024 bytes.  Average bytes/second read: 8726.444415
#fragments, #bytes: 2, 2048
Read 1024 bytes.  Average bytes/second read: 8790.244507
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 8848.177087
#fragments, #bytes: 0, 0
Read 1024 bytes.  Average bytes/second read: 8660.003933
#fragments, #bytes: 1, 1600
Read 1024 bytes.  Average bytes/second read: 8717.387832
[...cut...]

It doesn't feel right to read bytes when it says
that there are no fragments/bytes available.

Is the average bytes/second correct though?

with

Number of channels: 1
Sample rate: 22050

and AFMT_S16_LE, what should it be?  I am not so good
at calculating things without knowing the unity of the
'rate' ;)... bits/s?  Byte/s?  (16-bit)Words/sec?

Anyway, it seems too low or too high.
When I add back the "if (info.fragments > 0)" test
and decrease the naptime drastically, I get:

#fragments, #bytes: 1, 1088
Read 1024 bytes.  Average bytes/second read: 16057.031185
#fragments, #bytes: 0, 256
#fragments, #bytes: 0, 448
#fragments, #bytes: 0, 640
#fragments, #bytes: 0, 832
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 16060.372190
#fragments, #bytes: 0, 192
#fragments, #bytes: 0, 384
#fragments, #bytes: 0, 608
#fragments, #bytes: 0, 800
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 16059.965127
#fragments, #bytes: 0, 192
#fragments, #bytes: 0, 416
#fragments, #bytes: 0, 608
#fragments, #bytes: 0, 832
#fragments, #bytes: 1, 1024
Read 1024 bytes.  Average bytes/second read: 16059.006144
etc

Still nothing like 22050 - and certainly unequal to 8700.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
