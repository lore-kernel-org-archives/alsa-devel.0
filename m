From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 0/2] Dynamic routing for compressed streams.
Date: Fri, 17 Jan 2014 17:02:25 +0000
Message-ID: <1389978145.2353.29.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A0772610D4
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 18:02:28 +0100 (CET)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Changes for V2

 * We no longer copy the compressed params into the BE hw_params. This
was bogus, but didn't show up on Haswell testing as the BE params were
never used. The DSP ran the BE is a fixed configuration so all BE params
were ignored.

 * The BE hw_params are now zeroed to force the machine driver to fixup
the BE configuration. i.e. machine driver can query the DSP
encodec/decoder for correct hw_params given the use case.

 * No longer need to allocate memory for hw_params.

Regards

Liam
