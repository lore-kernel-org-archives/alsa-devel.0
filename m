From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Using sync dapm_sync in stream_event call back
Date: Wed, 7 Nov 2012 09:53:14 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C529E715@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEB4264FED
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 10:53:24 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi

In my machine driver, I need to disable a widget in stream_event call back.
I realized that I cannot invoke dapm_sync() inside the stream_event, because it causes recursive lock.

How can I disable a pin (widget) inside stream_event call back?

Thanks
Ramesh
