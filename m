From: "Wang, Kuirong" <kuirongw@quicinc.com>
Subject: How to trigger a widget?
Date: Mon, 20 Feb 2012 07:13:15 +0000
Message-ID: <D618B7A80E26984A9E4E1FD204983C1AA88700@nasanexd01d.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 61A52246DC
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 08:13:19 +0100 (CET)
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

As I saw many examples to use the snd_soc_dapm_enable_pin() to trigger a particular widget. But I saw the widget has to be like a speaker, mic, lineout, etc. Could I use the snd_soc_dapm_enable_pin() to trigger any type of widget I want?  I tried to use it to trigger a supply widget, but I never see it works even I did snd_soc_dapm_sync() after the enable_pin.  Could someone provide some inputs?

Appreciated your time.

Thanks,

Kuirong Wang
