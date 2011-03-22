From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 0/8] ALSA: VIA HDA: patch series
Date: Tue, 22 Mar 2011 14:26:47 +0800
Message-ID: <4D884127.4060505@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C1B4103800
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 07:26:56 +0100 (CET)
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
-add new power management functions of different codecs
-fix stereo mixer recording no sound issue
-fix independent headphone no sound issue
-fix invalid a-a path volume adjust issue for some codecs
-fix side channel has sound under independent hp mode of VT1718S issue
-correct display stream names for VT1818S
-fix hp mixer build fail of VT1708A issue
