From: "Leung Chi Tat" <ctleung@cct.com.hk>
Subject: Help on writing an ALSA ASoC Driver for WM8985
Date: Mon, 25 May 2009 11:31:48 +0800
Message-ID: <D6546E3E62D77445A7E4B9A0FD70CDE007A551C6@FTBM01.ft.cct.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp05.cct.com.hk (smtp05.cct.com.hk [210.0.232.103])
	by alsa0.perex.cz (Postfix) with ESMTP id AC7D7245D1
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 05:33:59 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm new to ALSA ASoC and ALSA.  I'd like get some advice where I can get more information about writing an ASoC driver. I've browsed the internet couples of days and I can only find links on ALSA driver api's and writing an ALSA driver for PCI devices.

It seems there is not much information on how to writing an ALSA ASoC driver.  I'm stuck on the following questions:
	1. describing those important structures, e.g. struct soc_enum, struct snd_kcontrol_new, struct snd_soc_dapm_widget;
	2. what is/are the relationships among those important structures;
	3. what is the differences between those controls for struct snd_kcontrol_new and struct snd_soc_dapm_widget;
	4. Should those sinks, sources, paths be defined in the arrays of struct snd_dapm_widget;
	5. How can I select those defined paths through ALSA user-mode library as I can't find any examples in those ALSA tutorials;

Indeed, I'm right now trying to write a WM8985 driver for my s3c6400 based platform based on the kernel source v2.6.21 from Samsung.

Thank you so much for your valuable advice and suggestions in advance.
 
Best Regards,
LEUNG, Chi Tat
Senior Software Engineer
CCT Tech Advanced Products Limited
18/F, CCT Telecom Building, 11 Wo Shing Street
Fo Tan, Shatin, N.T., Hong Kong
Tel: +852 26005276 Fax: +852 26948660
Email: ctleung@cct.com.hk
Website: http://www.cct-tech.com.hk
