From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: Re: maintaining fixed latency between output and input?
Date: Mon, 29 Sep 2008 16:34:45 -0700
Message-ID: <20080929233445.GG481@arwen.poofy.goof.com>
References: <20080926010525.GP1107@arwen.poofy.goof.com>
	<48DC822F.2030706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id C1EBE245A6
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 01:34:51 +0200 (CEST)
Received: from arwen.poofy.goof.com (muzgash.poofy.goof.com [10.0.0.26])
	by smtp.poofygoof.com (Postfix) with ESMTP id 34CA62940
	for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2008 16:34:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48DC822F.2030706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2008 at 08:33:19AM +0200, Clemens Ladisch wrote:
> To communicate with other threads, you can use a pipe so that you have
> a file descriptor that can be used with the poll().

now how to get posix message queues available to poll()?  (=

> Aaron J. Grier wrote:
> > combining the output and input snd_pcm_t into a single descriptor
> > list for poll() seems straight-forward, but can I pass this superset
> > list to snd_pcm_poll_descriptors_revents() without it getting
> > confused?
> 
> No, snd_pcm_poll_descriptors_revents() looks at the file descriptors of
> a single device and returns the ready status of that device.

to follow up to myself, I was able to allocate a contiguous array of
struct pollfd, and point ALSA at different sections of it.  the entire
array was handed to poll().  it seems to work as described, and my
timing is now a bit tighter than it previously was.

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com
