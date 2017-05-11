From: Christoph Hellwig <hch@lst.de>
Subject: future of sounds/oss
Date: Thu, 11 May 2017 10:21:33 +0200
Message-ID: <20170511082133.GA20304@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 by alsa0.perex.cz (Postfix) with ESMTP id B1BEE266718
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 10:21:34 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ho Jaroslav, hi Takashi,

do you know who still uses the sound/oss drivers and why?  I've
recently been looking into getting rid of set_fs for using
copy_{from,to}_user and friends on kernel pointers, and the sound
code is a big abuser, both ALSA and the legacy OSS code.

But looking at the OSS code it's pretty grotty, and also appears
to be pretty much unmaintained except for global cleanups.  Is there
any chance we could look into getting rid of it over the next few
merge windows or are there people that rely on it?
