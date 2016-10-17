From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Para-virtualized audio drivers
Date: Mon, 17 Oct 2016 03:01:47 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552C5B457@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 11655261560
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 05:01:55 +0200 (CEST)
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
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
Cc: 'Takashi Iwai' <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and all,

I have some need to develop para virtualized audio drivers which can
work with XEN hypervisor.

I see some attempt was made in the past.
https://lists.xen.org/archives/html/xen-devel/2015-01/msg02125.html

I see one more material but with no code.
http://rd.springer.com/chapter/10.1007%2F978-94-007-2105-0_46

I am thinking to develop pv-audio-frontend (running on Dom1) and 
pv-audio-backend (running on Dom0) drivers all at kernel level.
Backend driver owns the hardware. Frontend driver communicates with 
backend driver using XENbus framework just like storage and network PV
drivers.

Before I start, I wanted to check if there is any other
work that has been done which I can take as base ?

Regards,
Rakesh
