From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Underrun problem in capture and playback application
Date: Tue, 21 Dec 2010 20:40:37 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA635A7480DF@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FC211037F3
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 16:10:43 +0100 (CET)
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

Hello Developers

                            I have set following configuration for my capture and playback application I am getting lot of UNDERRUN.
How can i avoid buffer underruns.

At a time i am READING "BUFFERSIZE" frames and writing same number of frames in while loop.

SAMPLERATE             44100

PERIODSIZE_CAPTURE             1024
NUMBER_OF_PERIODS_CAPTURE      8

PERIODSIZE_PLAYBACK             512
NUMBER_OF_PERIODS_PLAYBACK      16

NUMBER_OF_CHANNELS     1
SAMPLESIZE             2
FRAMESIZE              (NUMBER_OF_CHANNELS * SAMPLESIZE)

BUFFERSIZE  =     (PERIODSIZE_CAPTURE * NUMBER_OF_PERIODS_CAPTURE)


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
