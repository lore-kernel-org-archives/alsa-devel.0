From: zhejiang <zhe.jiang@intel.com>
Subject: vaio_mux's num_items is not equal to the actual items
Date: Thu, 11 Oct 2007 17:13:13 +0800
Message-ID: <1192093994.19937.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D68DE244F0
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 11:14:07 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


In patch_sigmatel.c,

static struct hda_input_mux vaio_mux = {
	.num_items = 2,
	.items = {
		/* { "HP", 0x0 }, */
		{ "Mic Jack", 0x1 },
		{ "Internal Mic", 0x2 },
		{ "PCM", 0x3 },
	}
};

Why is the num_items  not 3 ?
The "PCM" won't be selected with num_times = 2.
