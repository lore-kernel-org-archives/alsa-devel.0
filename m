From: "Miartus, Adam (Arion Recruitment; ADITG/ESM)" <amiartus@de.adit-jv.com>
Subject: Re: [ALSA patch] [PATCH - alsa-lib 4/4] pcm_file: add
 infile read support for mmap mode
Date: Tue, 21 May 2019 08:37:43 +0000
Message-ID: <B174E9FCEE9A8C46B11E4DF2E329936277F364@HI2EXCH01.adit-jv.com>
References: <1558370831-15960-1-git-send-email-adam.miartus@gmail.com>
 <1558370831-15960-4-git-send-email-adam.miartus@gmail.com>
 <B174E9FCEE9A8C46B11E4DF2E329936277F234@HI2EXCH01.adit-jv.com>
 <s5hwoik5i7d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13A90F806E7
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 10:37:51 +0200 (CEST)
In-Reply-To: <s5hwoik5i7d.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> On Mon, 20 May 2019 18:51:06 +0200,
> Miartus, Adam (Arion Recruitment; ADITG/ESM) wrote:
> >
> > From: Adam Miartus <amiartus@de.adit-jv.com>
> >
> > mmap_begin callback is used to copy data from input file to mmaped
> > buffer
> >
> > guard for corner use of api (multiple mmap_begin calls by user) is
> > introduced to check if next continuous buffer was already overwritten
> >
> > buffer is overwritten with input file data only in case of stream
> > capture
> >
> > Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
> > Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
> 
> Can't we copy the data in snd_pcm_file_mmap_commit() just like the
> playback case?
> 
> 
> thanks,
> 
> Takashi

My understanding is that in case of reading data in mmap mode user
would call mmap_begin, read the buffer and then call mmap_commit.

In this case overwriting the buffer in mmap_commit with data from
Input file would be too late. 

Best regards,
Adam
