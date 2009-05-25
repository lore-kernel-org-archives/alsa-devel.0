From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Help on writing an ALSA ASoC Driver for WM8985
Date: Sun, 24 May 2009 23:44:40 -0400
Message-ID: <9e4733910905242044h45c5d8a6ie5f0c247c0796089@mail.gmail.com>
References: <D6546E3E62D77445A7E4B9A0FD70CDE007A551C6@FTBM01.ft.cct.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A73A2245D9
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 05:44:43 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4019642qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 20:44:42 -0700 (PDT)
In-Reply-To: <D6546E3E62D77445A7E4B9A0FD70CDE007A551C6@FTBM01.ft.cct.grp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leung Chi Tat <ctleung@cct.com.hk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
