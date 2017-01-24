From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Fix incorrect license in source
	comments.
Date: Tue, 24 Jan 2017 14:59:08 +0000
Message-ID: <1485269948.2625.50.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 0963E266D1E
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 15:59:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

The topology source files had the wrong licence specified in the
comments when initially upstreamed. The topology source files are all
licensed under the LGPL-2.1 and not the GPLv2.

All earlier versions of the alsa-lib topology source files must be
considered LGPL-2.1 like the other source files in alsa-lib and also
as specified in the alsa-lib COPYING file.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/builder.c | 17 +++++++++--------
 src/topology/channel.c | 17 +++++++++--------
 src/topology/ctl.c     | 17 +++++++++--------
 src/topology/dapm.c    | 17 +++++++++--------
 src/topology/data.c    | 17 +++++++++--------
 src/topology/elem.c    | 17 +++++++++--------
 src/topology/ops.c     | 17 +++++++++--------
 src/topology/parser.c  | 17 +++++++++--------
 src/topology/pcm.c     | 17 +++++++++--------
 src/topology/text.c    | 17 +++++++++--------
 10 files changed, 90 insertions(+), 80 deletions(-)

diff --git a/src/topology/builder.c b/src/topology/builder.c
index 20fa925..dcd9e2a 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/channel.c b/src/topology/channel.c
index c2f1fea..8516b23 100644
--- a/src/topology/channel.c
+++ b/src/topology/channel.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 907a97f..1da3d18 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 8c585a7..eef72bb 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/data.c b/src/topology/data.c
index 0d5c430..e2aa38c 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/elem.c b/src/topology/elem.c
index db26483..efcf3e9 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/ops.c b/src/topology/ops.c
index 1b5c1e2..6f8dc1f 100644
--- a/src/topology/ops.c
+++ b/src/topology/ops.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/parser.c b/src/topology/parser.c
index c5f9757..cfc20e0 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 8f8a703..5568d57 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
diff --git a/src/topology/text.c b/src/topology/text.c
index 303fbeb..cba6887 100644
--- a/src/topology/text.c
+++ b/src/topology/text.c
@@ -2,14 +2,15 @@
   Copyright(c) 2014-2015 Intel Corporation
   All rights reserved.
 
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
+  This library is free software; you can redistribute it and/or modify
+  it under the terms of the GNU Lesser General Public License as
+  published by the Free Software Foundation; either version 2.1 of
+  the License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU Lesser General Public License for more details.
 
   Authors: Mengdong Lin <mengdong.lin@intel.com>
            Yao Jin <yao.jin@intel.com>
-- 
2.9.3
