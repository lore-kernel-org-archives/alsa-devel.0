From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: core: add support for compress_offload
Date: Tue, 4 Sep 2012 19:33:00 +0300
Message-ID: <20120904163300.GA12172@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 105A126526D
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2012 18:33:09 +0200 (CEST)
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
To: vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Vinod Koul,

The patch b21c60a4edd2: "ALSA: core: add support for
compress_offload" from Dec 23, 2011, leads to the following warning:
sound/core/compress_offload.c:85 snd_compr_open()
	 warn: bitwise AND condition is false here

    83          if (f->f_flags & O_WRONLY)
    84                  dirn = SND_COMPRESS_PLAYBACK;
    85          else if (f->f_flags & O_RDONLY)
    86                  dirn = SND_COMPRESS_CAPTURE;
    87          else {
    88                  pr_err("invalid direction\n");
    89                  return -EINVAL;
    90          }

O_RDONLY is 0 so we never do compressed capture.  Perhaps the tests
should be:

	if ((file->f_flags & O_ACCMODE) == O_WRONLY)
		dirn = SND_COMPRESS_PLAYBACK;
	else if (file->f_flags & O_ACCMODE) == O_RDONLY)
		dirn = SND_COMPRESS_CAPTURE;
	else
		return -EINVAL;

Also it seems like a bad thing to print an error here, because can the
user flood dmesg?

regards,
dan carpenter
