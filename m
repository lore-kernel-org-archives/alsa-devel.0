From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Unable to open CAPTURE device
Date: Tue, 30 Nov 2010 12:33:12 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3B4@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CEF42413A
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 08:03:16 +0100 (CET)
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

Hello,

         I have connected ipod to my hardware (using USB) and i want to read the audio pcm data from ipod. I am running following section of code to detect connection of ipod. But i am not finding any capture device connected.
        Am i giving some wrong name of capture device ? If wrong how can i find correct name of Audio Capture device.

/***********************************************************************************************************************************************/
const char *capture_device="plughw:1,0";

while((retVal = snd_pcm_open( &pcm_capture, (const char *)capture_device, SND_PCM_STREAM_CAPTURE, 1))!=0)
{
  if (retVal != 0){
    printf("Opening Capture device FAILED\n");
    printf("Still waiting for Capture device to be connected\n");
    usleep(5000);
  }
}
/***********************************************************************************************************************************************/
OUTPUT :

Opening Capture device FAILED
Still waiting for Capture device to be connected
ALSA lib pcm_hw.c:1433:(_snd_pcm_hw_open) Invalid value for card
Opening Capture device FAILED
Still waiting for Capture device to be connected
ALSA lib pcm_hw.c:1433:(_snd_pcm_hw_open) Invalid value for card
Opening Capture device FAILED
Still waiting for Capture device to be connected
ALSA lib pcm_hw.c:1433:(_snd_pcm_hw_open) Invalid value for card
Opening Capture device FAILED
Still waiting for Capture device to be connected
ALSA lib pcm_hw.c:1433:(_snd_pcm_hw_open) Invalid value for card
Opening Capture device FAILED
Still waiting for Capture device to be connected
.
.
.
.
.
.
.
/*Continues*/
.
.
.
.
.
.
.
.
.
.
.
.
.

Regards


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
