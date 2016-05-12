From: nick83ola <nick83ola@gmail.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Thu, 12 May 2016 09:55:25 +0200
Message-ID: <CABPh3UOUf=wsw5uRKP3pJO+Z5CCMcdJCOyQmExCucYrK-4-84w@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
 <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
 <CAG5mAdw1erm=4RjMfP-hf1Vkw73KCWSaLbU3DtditMfsFQNRdQ@mail.gmail.com>
 <CABPh3UN2157eMxwr6i8-vPfdyr3L0DOrpVt7ChTUrPTCbCzCBA@mail.gmail.com>
 <CABPh3UNk9xa=K7QiVV3pZba7o287AyOrjufUGd1QWUxnHNHLOg@mail.gmail.com>
 <CAG5mAdyCAgtFBCbAyLVtqtLgOtCgkB9=yV+YEY8a3oeL2yJDHA@mail.gmail.com>
 <CABPh3UPzP1iFYsy_Ni1fcfimnoVDUWfdn8ht5On_mx0xN1w8Mg@mail.gmail.com>
 <CAG5mAdyceKw_H7zNfx-KTSUUMc81UiLu3feLBcB+vjjjpuhetQ@mail.gmail.com>
 <CABPh3UNPDS+4H60eeL79etF70O0-Xp2T_oNBkYL2m4g6jpeSWA@mail.gmail.com>
 <CAG5mAdw8oWy38SBzYTKi9DeCS5UzcMNjY5VsFCARp6yDb76cFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 37603265300
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 09:55:45 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id m101so7178217lfi.1
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 00:55:45 -0700 (PDT)
In-Reply-To: <CAG5mAdw8oWy38SBzYTKi9DeCS5UzcMNjY5VsFCARp6yDb76cFg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am using ssi1 because I have an example of setting master mode on sabre
board dts

I have a problem with iomux/pinctrl  I think because

root@icorem6solo:/sys/kernel/debug/pinctrl/20e0000.iomuxc# cat pinmux-pins
|grep audmux
pin 57 (MX6DL_PAD_DISP0_DAT20): 2028000.ssi (GPIO UNCLAIMED) function
audmux group audmux-4
pin 58 (MX6DL_PAD_DISP0_DAT21): 2028000.ssi (GPIO UNCLAIMED) function
audmux group audmux-4
pin 59 (MX6DL_PAD_DISP0_DAT22): 2028000.ssi (GPIO UNCLAIMED) function
audmux group audmux-4
pin 60 (MX6DL_PAD_DISP0_DAT23): 2028000.ssi (GPIO UNCLAIMED) function
audmux group audmux-4

says: GPIO_UNCLAIMED? it is correct??

/sys/kernel/debug/pinctrl/20e0000.iomuxc# cat pinconf-groups |grep -A 1
audmux
1 (audmux-1):
MX6DL_PAD_SD2_DAT0: 0x17070MX6DL_PAD_SD2_DAT3: 0x17070MX6DL_PAD_SD2_DAT2:
0x17070MX6DL_PAD_SD2_DAT1: 0x17070
2 (audmux-2):
MX6DL_PAD_CSI0_DAT7: 0x1b0b0MX6DL_PAD_CSI0_DAT4:
0x1b0b0MX6DL_PAD_CSI0_DAT5: 0x1b0b0MX6DL_PAD_CSI0_DAT6: 0x1b0b0
3 (audmux-3):
MX6DL_PAD_DISP0_DAT16: 0x10MX6DL_PAD_DISP0_DAT18:
0x1b0b0MX6DL_PAD_DISP0_DAT19: 0x1b0b0
4 (audmux-4):
MX6DL_PAD_DISP0_DAT20: 0x130b0MX6DL_PAD_DISP0_DAT21:
0x110b0MX6DL_PAD_DISP0_DAT22: 0x130b0MX6DL_PAD_DISP0_DAT23: 0x130b0

0x130b0?

audmux# cat ssi0
    PDCR: 0000a000
    PTCR: ad400800
    TxFS output from SSI6, TxClk output from SSI6
    Port is symmetric
    Data received from SSI6
root@icorem6solo:/sys/kernel/debug/audmux# cat ssi1
    PDCR: 00008000
    PTCR: 00000800
    TxFS input, TxClk input
    Port is symmetric
    Data received from SSI5
root@icorem6solo:/sys/kernel/debug/audmux# cat ssi2
    PDCR: 00006000
    PTCR: 9cc00800
    TxFS output from SSI4, TxClk output from SSI4
    Port is symmetric
    Data received from SSI4
root@icorem6solo:/sys/kernel/debug/audmux# cat ssi3
    PDCR: 00004000
    PTCR: 00000800
    TxFS input, TxClk input
    Port is symmetric
    Data received from SSI3
root@icorem6solo:/sys/kernel/debug/audmux# cat ssi4
    PDCR: 00002000
    PTCR: 8c400800
    TxFS output from imx-ssi.1, TxClk output from imx-ssi.1
    Port is symmetric
    Data received from imx-ssi.1
root@icorem6solo:/sys/kernel/debug/audmux# cat ssi5
    PDCR: 00000000
    PTCR: 00000800
    TxFS input, TxClk input
    Port is symmetric
    Data received from imx-ssi.0
root@icorem6solo:/sys/kernel/debug/audmux# cat ssi6
    PDCR: 0000c000
    PTCR: 00000800
    TxFS input, TxClk input
    Port is symmetric
    Data received from UNKNOWN
