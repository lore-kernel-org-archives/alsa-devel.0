From: nick83ola <nick83ola@gmail.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Fri, 13 May 2016 10:21:08 +0200
Message-ID: <CABPh3UPJ6fRoVSo8cvfKkmBMopVsB9Gu03bBhaegg14+PLD1OQ@mail.gmail.com>
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
 <CABPh3UOUf=wsw5uRKP3pJO+Z5CCMcdJCOyQmExCucYrK-4-84w@mail.gmail.com>
 <CABPh3UOnt9ZWYn4dA6xf0DzFdRvNY7QsSv5mzD2Z5UufU3gVhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 91115260438
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 10:21:28 +0200 (CEST)
Received: by mail-lb0-f178.google.com with SMTP id h1so21978473lbj.3
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 01:21:28 -0700 (PDT)
In-Reply-To: <CABPh3UOnt9ZWYn4dA6xf0DzFdRvNY7QsSv5mzD2Z5UufU3gVhg@mail.gmail.com>
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

also you have a typo in your dts I think that the define is

#define AUDMUX_EXT_PORT_NAME port5

not

#define AUDMUX_INT_PORT_NAME port5

and -> correct the other

(i found that imx-audmux support audmux port-config...)
