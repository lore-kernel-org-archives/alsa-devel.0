From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
Subject: Re:
 =?utf-8?q?=5BALSA_patch=5D_=5BPATCH_-_alsa-lib_4/4?=
 =?utf-8?q?=5D_pcm=5Ffile=3A_add=09infile_read_support_for_mmap_mode?=
Date: Tue, 21 May 2019 18:19:42 +0900
Message-ID: <c818a451-6bea-481f-8c58-c6746aef203f@www.fastmail.com>
References: <1558370831-15960-1-git-send-email-adam.miartus@gmail.com>
 <1558370831-15960-4-git-send-email-adam.miartus@gmail.com>
 <B174E9FCEE9A8C46B11E4DF2E329936277F234@HI2EXCH01.adit-jv.com>
 <s5hwoik5i7d.wl-tiwai@suse.de>
 <B174E9FCEE9A8C46B11E4DF2E329936277F364@HI2EXCH01.adit-jv.com>
 <s5hr28s5gxz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A05FF806E7
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 11:19:44 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 24166250C3
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 05:19:43 -0400 (EDT)
In-Reply-To: <s5hr28s5gxz.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, May 21, 2019, at 17:52, Takashi Iwai wrote:
> On Tue, 21 May 2019 10:37:43 +0200,
> Miartus, Adam (Arion Recruitment; ADITG/ESM) wrote:
> > 
> > > On Mon, 20 May 2019 18:51:06 +0200,
> > > Miartus, Adam (Arion Recruitment; ADITG/ESM) wrote:
> > > >
> > > > From: Adam Miartus <amiartus@de.adit-jv.com>
> > > >
> > > > mmap_begin callback is used to copy data from input file to mmaped
> > > > buffer
> > > >
> > > > guard for corner use of api (multiple mmap_begin calls by user) is
> > > > introduced to check if next continuous buffer was already overwritten
> > > >
> > > > buffer is overwritten with input file data only in case of stream
> > > > capture
> > > >
> > > > Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
> > > > Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
> > > 
> > > Can't we copy the data in snd_pcm_file_mmap_commit() just like the
> > > playback case?
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > 
> > My understanding is that in case of reading data in mmap mode user
> > would call mmap_begin, read the buffer and then call mmap_commit.
> > 
> > In this case overwriting the buffer in mmap_commit with data from
> > Input file would be too late. 
> 
> Hm, OK.  I basically hate to add a new ops, but this might be the only
> way if we have to implement that.

I'm interested in this patch, however the patch is not blasted by list server.
Would you please re-post your patchset so that the list server delivers them
to subscribers and I can see the contents?

> OTOH, is this mmap support mandatory?  IOW, is wrapping with the plug
> and mmap_emul performance-wise so bad?


Regards

Takashi Sakamoto
