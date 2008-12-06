From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Xrun stack trace for 1010LT
Date: Sat, 6 Dec 2008 14:46:37 +0000
Message-ID: <20081206144637.GA2390@localhost>
References: <20081205194119.GA3669@localhost>
	<351954.41071.qm@web65406.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id E69CB245E7
	for <alsa-devel@alsa-project.org>; Sat,  6 Dec 2008 15:33:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <351954.41071.qm@web65406.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pete <peterpion@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2008 at 01:39:33PM -0800, Pete wrote:
> I was confusing the two. Ill work on the kernel over the weekend. In the meantime I recompiled it without the rt patch today and have this in my stack trace:

<snip>
> Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623776]  [<f88ee8f2>] journal_dirty_data+0xb2/0x250 [jbd]
> Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623793]  [<f890f8a8>] ext3_journal_dirty_data+0x18/0x50 [ext3]
> Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623811]  [<f89104b0>] ext3_get_block+0x0/0x100 [ext3]
> Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623830]  [<f890eb12>] walk_page_buffers+0x32/0x70 [ext3]
> Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623849]  [<f89116d4>] ext3_ordered_write_end+0x74/0x180 [ext3]
> Dec  5 21:28:31 ubuntu-studio kernel: [ 1115.623866]  [<f890f890>] ext3_journal_dirty_data+0x0/0x50 [ext3]
</snip>
> 
> Several times over.  Would this suggest that the ext3 filesystem is 
> my problem? What is going on exactly?

Looks like ext3 could be a problem. jackd uses /dev/shm as a temporary
filesystem to get round this. You might have to mount the filesystem as
ext2 (or use jackd).

John
