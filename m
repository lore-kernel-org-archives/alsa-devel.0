From: FF <lgperson@126.com>
Subject: About Alsa arecord
Date: Mon, 7 Jan 2013 10:43:33 +0800 (CST)
Message-ID: <2871c441.3cd4.13c12e43f7b.Coremail.lgperson@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m15-61.126.com (m15-61.126.com [220.181.15.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DC442650B9
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 03:43:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!
       There have 2 stereo ADCs support one stereo microphone and one legacy mixer recording simultaneously, said in the document of ALC888 Datasheet .I inputed 1KHz sine wave into every pins (Line1-R,Line1-L,MIC1-R,MIC1_L,MIC2-R,MIC2-L,LINE2-R,LINE2-L) of ALC888 by signal genrator,and used command 'arecord -c 4 -f S16_LE -r 44100 >test.wav' recording in fedora14.but ALL audio data are recorded in channel 1,2.No any data in channel 3,4.Why?How can I record every pins audio data in each channel?
        Thank you!Best regards.
