From: "Leung Chi Tat" <ctleung@cct.com.hk>
Subject: Re: Help on writing an ALSA ASoC Driver for WM8985
Date: Mon, 25 May 2009 13:57:11 +0800
Message-ID: <D6546E3E62D77445A7E4B9A0FD70CDE007A552B6@FTBM01.ft.cct.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp05.cct.com.hk (smtp05.cct.com.hk [210.0.232.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E4EF103800
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 08:01:02 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you so much for your suggestion.  =


I've already copied a codec source for wm8980 from linux-2.6-ASoC main trun=
k.  I have already to modify it back to the old api's and old structures fo=
r kernel v2.6.21.  What remains I can't get through are those points I list=
ed in my previous email.

Could you give me some hints?

Best Regards,
LEUNG, Chi Tat
Senior Software Engineer
CCT Tech Advanced Products Limited
18/F, CCT Telecom Building, 11 Wo Shing Street
Fo Tan, Shatin, N.T., Hong Kong
Tel: +852 26005276 Fax: +852 26948660
Email: ctleung@cct.com.hk
Website: http://www.cct-tech.com.hk


-----Original Message-----
From: Jon Smirl [mailto:jonsmirl@gmail.com]
Sent: Monday, May 25, 2009 11:45 AM
To: Leung Chi Tat
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Help on writing an ALSA ASoC Driver for WM8985


On Sun, May 24, 2009 at 11:31 PM, Leung Chi Tat <ctleung@cct.com.hk> wrote:
> Hi all,
>
> I'm new to ALSA ASoC and ALSA. =A0I'd like get some advice where I can ge=
t more information about writing an ASoC driver. I've browsed the internet =
couples of days and I can only find links on ALSA driver api's and writing =
an ALSA driver for PCI devices.
>
> It seems there is not much information on how to writing an ALSA ASoC dri=
ver. =A0I'm stuck on the following questions:
> =A0 =A0 =A0 =A01. describing those important structures, e.g. struct soc_=
enum, struct snd_kcontrol_new, struct snd_soc_dapm_widget;
> =A0 =A0 =A0 =A02. what is/are the relationships among those important str=
uctures;
> =A0 =A0 =A0 =A03. what is the differences between those controls for stru=
ct snd_kcontrol_new and struct snd_soc_dapm_widget;
> =A0 =A0 =A0 =A04. Should those sinks, sources, paths be defined in the ar=
rays of struct snd_dapm_widget;
> =A0 =A0 =A0 =A05. How can I select those defined paths through ALSA user-=
mode library as I can't find any examples in those ALSA tutorials;
>
> Indeed, I'm right now trying to write a WM8985 driver for my s3c6400 base=
d platform based on the kernel source v2.6.21 from Samsung.

Look in sound/soc/codecs. There are implementations for many similar
Wolfson chips. Just cut and paste them together to make the wm8985.


>
> Thank you so much for your valuable advice and suggestions in advance.
>
> Best Regards,
> LEUNG, Chi Tat
> Senior Software Engineer
> CCT Tech Advanced Products Limited
> 18/F, CCT Telecom Building, 11 Wo Shing Street
> Fo Tan, Shatin, N.T., Hong Kong
> Tel: +852 26005276 Fax: +852 26948660
> Email: ctleung@cct.com.hk
> Website: http://www.cct-tech.com.hk
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
