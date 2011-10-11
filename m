From: Anders Gnistrup <agn@datarespons.dk>
Subject: question for the snd_pcm_mmap_writen.
Date: Tue, 11 Oct 2011 14:06:41 +0200
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5826629B96@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id C510424373
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 14:06:44 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

First post to the mail list.
I have been reading through the Alsa API and tutorials and it all seems fairly simple.
But I still have some questions for the sample format possible to send using the mmap method.

First a short description of my problem.
I have a embedded device with a 8 channel audio chip.
I only have to use 5 of these channels
My goal is not to use any cpu cycles on the 3 unused channels

I have decided to use the non-interleaved method (application specific, streams comes from different sources in a correct hardware specific format).

For this, the function snd_pcm_mmap_writen could be used.
When sending data to the device the format should/could be done using a 5 seperate buffers.

snd_pcm_sframes_t snd_pcm_mmap_writen 	(snd_pcm_t *  	pcm,
                                                                 void **  	bufs,
                                                                 snd_pcm_uframes_t  	size)

where *bufs[0] equal to first channel *bufs[1] equals to next etc.
Q1)
Should/must the **bufs be continuations -> bufs[0][size]==bufs[1][0]???

Q2)
Is is possible the set bufs[2] == NULL, to signal that the channel is unused?

I think I know the answers.
Yes, it should be continues, No data can be set to NULL.

Q3)
I have tried to find some information about the SND_PCM_ACCESS_MMAP_COMPLEX. What is this??? 
My best gees is that it is some entirely hardware specific access format?


Regards Anders Gnistrup  
