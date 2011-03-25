From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: DAPM widgets beyond 2.6.38
Date: Thu, 24 Mar 2011 19:47:40 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DAC058842@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 44C672432E
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 03:48:00 +0100 (CET)
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal
	[10.16.15.104]) by antispam01.maxim-ic.com with ESMTP id
	SRDuIyKxfmwO8UW0 for <alsa-devel@alsa-project.org>;
	Thu, 24 Mar 2011 21:47:58 -0500 (CDT)
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

1) In 2.6.38, after these 2 operations: 
  snd_soc_dapm_new_controls(dapm, dapm_widgets, ARRAY_SIZE(dapm_widgets));
  snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
Is it *always* necessary to call snd_soc_dapm_new_widgets(dapm)?  
I have seen one case where it was not called.

2) In 2.6.39, to do the same, is there any function to call other than the table entries?

Thanks,

Peter
