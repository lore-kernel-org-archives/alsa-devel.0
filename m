From: Shaju Abraham <shaju@multitech.co.in>
Subject: Correct me if I am wrong & few questions
Date: Wed, 21 Aug 2002 11:10:53 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6327E5.D1F610F3@multitech.co.in>
References: <s5hlm71sst7.wl@alsa2.suse.de>
		<Pine.LNX.4.21.0208201320350.682-100000@summer.quitte> <s5hznvhtprx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id HAA23974
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 07:43:53 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,
           The following is my understanding ....pls correct me if I am
wrong.

1.     Buffer_size is how much of memory has been allocated to buffer the
sound to be played out.

2.     Fragment size is the measure of amount of data played between two
consecutive interrupts raised by the card.

3.    frags is the count of fragments the buffer (of size buffer_size ) has
been divided into.  ( frags may be more than the number of bds available i.e
32 ) ..  Hence it follows that

4.     Both of the following two cases are possible, right?

                     i) the whole buffer (of size buffer_size ) can be
divided between 32 bds so that a given bd will always point to same address
during the ourse of emptying the buffer

                    ii) If I force the fragment size to be small, the big
buffer_size can be get divided into more than 32 frags.  So a given bd will
be pointing to different places in the buffer during              the course
of emptying the buffer.


Now I have a few questions pls.

1.    The number of fragments i.e frags won't increase beyond 1024.  is this
correct?  Because given a big buffer_size, I am unable to force the fragment
size to be smaller than a certain size .( the final size being such that
frags is 1024 )

2.    What is the relation between runtime->period_size, runtime->periods
and runtime->buffersize  ( in pcm_native.c ) and ichdev->size ,
ichdev->period_size, ichdev->frags ( in intel8x0.c)

3.    I have a situation where I do not want to use all of the 32 bds
available. I want to use say only 2 or 4 of the bds with each bd pointing to
only a small fragment of data.( This is basically to give rise to a
condition where the card will not be able to proceed if the interrupts
raised by the past bds have not been serviced. 32 is a big number. I want to
restrict it to 2 or 4 ) . So, ..

            i)  What is the significance of ICH_MAX_FRAGS?  It seems to be
used only for the allocation of pages for the buffer and for little else
during the actual functioning of the card.

            ii)    What is the significance of ICH_REG_LVI_MASK?  (This is
more used during the actual functioning of the card & is used in the
interrupt service sub-routine to update the lvi.)  It is by default 0x1f .
Is this 'cos it can be used to address the 32 bds available.  I changed this
to 3 and 7 . I observed that this makes the card to use only 4 or 8 of the
bds available. Am I correct in this conclusion?  If I do this, I get some
noise. Is this because of the interrupts raised by the unused bds?

            iii) If I am wrong abt all this, how should I go abt my idea of
using only 2 or 4 of the bds available?


Clarifications on any points in the mail are welcome.


Thanx in advance,
--Shaju



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
