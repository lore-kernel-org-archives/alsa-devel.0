From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 17/22] docs: soundwire: locking: fix tags for a code-block
Date: Wed, 29 May 2019 20:23:48 -0300
Message-ID: <e27b6a1699b366feb03d50cc1bc0cbbc15c881a2.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There's an ascii artwork at Example 1 whose code-block is not properly
idented, causing those warnings.

    Documentation/driver-api/soundwire/locking.rst:50: WARNING: Inconsistent literal block quoting.
    Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
    Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
    Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/soundwire/locking.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/soundwire/locking.rst b/Documentation/driver-api/soundwire/locking.rst
index 253f73555255..3a7ffb3d87f3 100644
--- a/Documentation/driver-api/soundwire/locking.rst
+++ b/Documentation/driver-api/soundwire/locking.rst
@@ -44,7 +44,9 @@ Message transfer.
      b. Transfer message (Read/Write) to Slave1 or broadcast message on
         Bus in case of bank switch.
 
-     c. Release Message lock ::
+     c. Release Message lock
+
+     ::
 
 	+----------+                    +---------+
 	|          |                    |         |
-- 
2.21.0
