From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 0/4] Fix a broken/missing documentation at sound
Date: Tue, 26 Jun 2018 06:24:36 -0300
Message-ID: <cover.1530004939.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com (osg.samsung.com [64.30.133.232])
 by alsa0.perex.cz (Postfix) with ESMTP id CE1D62675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:24:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

After running ./scripts/documentation-file-ref-check I noticed that it
was complaining about the lack of a MultiSound file that used to be
inside the old OSS sound system.

That's actually a script, with seems to be needed in order to make
the multisound driver to work. Also, it contains some instructions
about how to use the module.

Granted, this is old ISA stuff, but, as long as the driver remains in
Kernel, it probably makes sense to keep the script somewhere.

So, this patch restores the file from the git log, moving it to an
existing directory and updates the module names. 

It also fixes the script, as it has some issues that prevents it to work
with modern distributions (basically, include stuff at C files it
produces).

-

Please notice that I don't have such hardware to test. So, I have no 
means to know if the produced exec file still makes sense.

Mauro Carvalho Chehab (4):
  sound: restore MultiSound script
  alsa: multisound.sh: fix script to make it build with modern tools
  alsa: multisound.sh: update module namespace
  alsa: Fix references to Documentation/.*/MultiSound

 Documentation/sound/alsa-configuration.rst |    2 +-
 Documentation/sound/cards/multisound.sh    | 1139 ++++++++++++++++++++
 sound/isa/Kconfig                          |    2 +-
 3 files changed, 1141 insertions(+), 2 deletions(-)
 create mode 100755 Documentation/sound/cards/multisound.sh

-- 
2.17.1
