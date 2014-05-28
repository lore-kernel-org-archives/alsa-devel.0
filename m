From: Benoit Taine <benoit.taine@lip6.fr>
Subject: [PATCH 0/2] Use resource_size instead of computation
Date: Wed, 28 May 2014 17:14:05 +0200
Message-ID: <1401290047-30005-1-git-send-email-benoit.taine@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: benoit.taine@lip6.fr, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

These patches enhance kernel style usage, and make use of the
resource_size() function instead of explicit computation.

The semantic patch at scripts/coccinelle/api/resource_size.cocci was
used to detect and edit this situation.
