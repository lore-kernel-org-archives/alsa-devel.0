From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Thu, 17 Jun 2010 07:34:13 +0800
Message-ID: <AANLkTim8q8dbV5-jyeHev1lh1b8HQOzhEETKBSa4o1Ol@mail.gmail.com>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
	<hv912l$j53$1@dough.gmane.org>
	<AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>
	<hvbgo6$3fg$1@dough.gmane.org>
	<AANLkTinYBKzxiITOnspsn2QOh_Rdv8FHu_PC7K7cGCXm@mail.gmail.com>
	<4C1951F1.4000504@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 80E601037E3
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 01:34:27 +0200 (CEST)
Received: by vws6 with SMTP id 6so950621vws.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 16:34:24 -0700 (PDT)
In-Reply-To: <4C1951F1.4000504@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/17 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 16/06/10 23:09 did gyre and gimble:
> > It is either a alsa-pulse bug in delcaring not the full range of the
> volume
> > control or the pulseaudio server return the wrong value
>
> Dude, I've already explained *exactly* what's up here. I don't really
> see it as a problem, but restating over and over certainly isn't going
> to change anything.
>
> I can't really be bothered discussing this with you any further as it's
> clear your not even reading my replies.
>
> Col
>

The alsamixer was fixed to ensure that control volume values are in their
allowed range

so this is why 98304 was set back to allowed range , but it did not fix the
root cause of the problem

>> But this sucks as
>> the percentage shown in alsa is not the same as the percentage shown in
>> other GUIs.

alsamixer and amixer 's percentage were not designed as your purpose

Have you studied the source code of alsamixer and amixer

the alsa developers have already posted a lot of time in the mailist list ,
they prefer to use dB scale instead of percentage

http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=c9b86f49a8a1a8c337bf0c1b7f12749e8be781ed
