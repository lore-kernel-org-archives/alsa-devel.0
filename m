From: Daniel Drake <drake@endlessm.com>
Subject: Re: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Sat, 29 Apr 2017 09:27:56 -0600
Message-ID: <CAD8Lp46A9oDMTabXuMPutMtP5Fkbgc4HXVwtNj2dbrrSDe+bUA@mail.gmail.com>
References: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
 <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
 <CAD8Lp44uqQW9+V_ZgB4LLXa8WFb+=CX8hT8PmWbZEGFhZGTvBw@mail.gmail.com>
 <7dbec345-e058-18ca-b4b3-e071fbc08fb0@linux.intel.com>
 <CAD8Lp47u3ERC_pn4ScJ6DQZ9HOuDcUZ0zM4fEQ99c3EVzP_YXA@mail.gmail.com>
 <1493375701.2540.53.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F88250258C@SHSMSX103.ccr.corp.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F882502622@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 87E342666FE
 for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2017 17:27:58 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id w12so54272357oiw.3
 for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2017 08:27:58 -0700 (PDT)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F882502622@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Apr 28, 2017 at 10:21 AM, Lin, Mengdong <mengdong.lin@intel.com> wrote:
> I just submitted a patch to fix this http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120271.html
> It passed building and I will test it next Tuesday. 3 Intel machines may have null DMI_SYS_VENDOR.

Thanks! I tested the patch on my platform here, and it is working
correctly, I now get the expected vendor name appearing in the string.

Daniel
