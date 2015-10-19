From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Implementing sub-stream multiplexing in DAI
Date: Mon, 19 Oct 2015 10:11:12 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552A848D9@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC592657FE
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 12:11:17 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "Shah,
 Hardik T" <hardik.t.shah@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

In order to implement sub-stream multiplexing as a part of single BE DAI I 
have following observations.

1. All BE DAI ops gets called only once even if two different FE DAIs are 
connected to a BE DAI.
2. BE DAI ops are always called with sub-stream 0.

are these expected ?

What is the best way to allow calling of BE DAI ops with different 
sub-stream ID so that I can do link configuration based on sub-stream 
parameters ? can you give some pointers ?

Regards,
Rakesh
