From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: License for UCM config files - re plumbers audio conf
	discussion.
Date: Thu, 12 Jan 2017 11:01:29 +0000
Message-ID: <1484218889.2604.85.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 895A3266860
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 12:01:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "mengdong.lin" <mengdong.lin@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

During the plumbers audio conference we discussed changing the release
cadence and packaging of the UCM config files. This was to separate them
from the alsa-lib package and alsa-lib release cadence for easier and
more timely distribution for Ubuntu, Fedora etc.

One thing that we did not cover was the UCM config file licence, if
indeed there is a license for the UCM config files ? It's clear to me
that the alsa-lib source and headers are LGPL, but does the LGPL also
apply to the runtime UCM config files ? LGPL is specifically designed
for libraries so my understanding is that it's probably not applicable
to the UCM runtime configuration files.  

Here the LGPL definition of source code from alsa-lib COPYING :-

  ""Source code" for a work means the preferred form of the work for
making modifications to it.  For a library, complete source code means
all the source code for all modules it contains, plus any associated
interface definition files, plus the scripts used to control compilation
and installation of the library."

Having a licence free or BSD/MIT type license for the UCM config repo
would mean the configurations (or derivatives of) could also be used
with Android.

IANAL

Liam
