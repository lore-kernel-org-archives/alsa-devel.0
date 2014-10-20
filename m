From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Update HSW/BDW SST driver to
 new FW architecture
Date: Mon, 20 Oct 2014 15:07:08 +0100
Message-ID: <1413814028.2512.37.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 65392266606
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:09:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The following patch series updates the current upstream driver to use
the new more feature rich ADSP FW architecture. The new FW arch allows
for multiple instantiation of objects in dynamic memory locations.

In summary :-

 o Modules can be created multiple times.
 o Modules persistent data can be allocated in any free blocks
 o Global scratch data can be allocated into any free blocks.
 o DMA can be used to load the module data.

The driver now has to track and manage the new multiple module resource
allocations and pass this data to FW on stream initialisations.

Thanks

Liam
