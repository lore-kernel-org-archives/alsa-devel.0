From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 0/6] ALSA: VIA HDA: patch series
Date: Thu, 24 Mar 2011 12:38:17 +0800
Message-ID: <4D8ACAB9.6060607@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id E812A103948
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 05:38:24 +0100 (CET)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

Following patch series mainly includes:
-fix side channel mute invalid issue of VT2002P, VT1812 and VT1802
-add VT1802 check in via_speaker_automute function
-update VT1708 initial verbs
-update VT1718S initial verbs
-update VT2002P initial verbs
-update unsolicited event function to process more events
